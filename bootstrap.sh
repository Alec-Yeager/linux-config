#!/usr/bin/env bash
set -euo pipefail

# ========== CONFIG ==========
REPO_URL="https://github.com/Alec-Yeager/linux-config.git"

# ========== UTILITIES ==========
log() { echo -e "\033[1;32m[+] $*\033[0m"; }
warn() { echo -e "\033[1;33m[!] $*\033[0m"; }
fail() { echo -e "\033[1;31m[✗] $*\033[0m" >&2; exit 1; }

# ========== DETECT OS ==========
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS_NAME=$(echo "$NAME" | awk '{print $1}')
    OS_ID="$ID"
else
    fail "Cannot detect OS from /etc/os-release."
fi
log "Detected OS: $OS_NAME ($OS_ID)"

TARGET_DIR="$HOME/$OS_NAME"
mkdir -p "$TARGET_DIR"

# ========== DETERMINE PACKAGE MANAGER ==========
if command -v pacman &>/dev/null; then
    PKG_INSTALL="sudo pacman -S --noconfirm --needed"
    OS_BASE="arch"
elif command -v apt &>/dev/null; then
    PKG_INSTALL="sudo apt update && sudo apt install -y"
    OS_BASE="debian"
elif command -v dnf &>/dev/null; then
    PKG_INSTALL="sudo dnf install -y"
    OS_BASE="fedora"
else
    fail "Unsupported distribution: $OS_NAME"
fi

# ========== INSTALL GIT ==========
log "Installing git..."
eval "$PKG_INSTALL git"

# ========== CLONE CONFIG REPO ==========
if [[ ! -d "$TARGET_DIR/linux-config" ]]; then
    log "Cloning $REPO_URL..."
    git clone "$REPO_URL" "$TARGET_DIR/linux-config"
else
    log "Updating existing config repo..."
    git -C "$TARGET_DIR/linux-config" pull
fi

# ========== SETUP STOW ==========
log "Linking dotfiles..."
#cp -r "$TARGET_DIR/linux-config"/.[!.]* "$HOME"/ 2>/dev/null || true
eval "$PKG_INSTALL stow" || fail "Stow not available. Cannot link dotfiles."

# Distros ship a default ~/.bashrc that would block stowing the shell package
if [[ -f "$HOME/.bashrc" && ! -L "$HOME/.bashrc" ]]; then
    if [[ -e "$HOME/.bash_local" ]]; then
        warn "~/.bashrc and ~/.bash_local both exist. Leaving them alone; the shell package will not be linked."
    else
        log "Moving existing ~/.bashrc to ~/.bash_local..."
        mv "$HOME/.bashrc" "$HOME/.bash_local"
    fi
fi

# One package at a time so a conflict in one does not block the rest
for package in nvim i3 kitty shell tmux; do
    stow -d "$TARGET_DIR/linux-config/dotfile-packages" -t "$HOME" "$package" \
        || warn "Failed to link $package. Move the conflicting files and rerun stow."
done

# ========== INSTALL NEOVIM (GLOBAL) ==========
# Tarball rather than AppImage: AppImages need libfuse2, which newer distros no longer ship by default
install_neovim() {
    log "Installing Neovim globally..."
    local tmpDir
    tmpDir=$(mktemp -d)
    curl -fL -o "$tmpDir/nvim.tar.gz" https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf "$tmpDir/nvim.tar.gz"
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    rm -rf "$tmpDir"
}

# ========== INSTALL STARSHIP ==========
install_starship() {
    log "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
}

# ========== INSTALL Z, ZSH, KITTY, LUAROCKS, TMUX, NVIM TOOLS ==========
install_general_packages() {
    log "Installing kitty, zoxide, zsh, luarocks, tmux, ripgrep, unzip..."
    eval "$PKG_INSTALL kitty zoxide zsh luarocks tmux ripgrep unzip" || warn "Some packages may not be found on this distro."
}

# ========== INSTALL NERD FONT ==========
install_nerdfont() {
    log "Installing RobotoMono Nerd Font..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)" nerd-fonts-installer RobotoMono
}

# ========== INSTALL PYENV ==========
install_pyenv() {
    log "Installing pyenv dependencies for $OS_BASE..."

    case "$OS_BASE" in
        debian)
            sudo apt update
            sudo apt install -y make build-essential libssl-dev zlib1g-dev \
                libbz2-dev libreadline-dev libsqlite3-dev curl git \
                libncurses-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
                libffi-dev liblzma-dev direnv python3-venv
            ;;
        arch)
            sudo pacman -S --needed --noconfirm base-devel direnv openssl zlib xz tk zstd
            ;;
        *)
            warn "Pyenv build dependencies not defined for $OS_BASE."
            ;;
    esac

    if [[ ! -d "$HOME/.pyenv" ]]; then
        log "Installing pyenv..."
        curl -fsSL https://pyenv.run | bash
    fi
}

set_defaults() {
        log "Setting Kitty as default terminal..."
    # Debian/Ubuntu only: set kitty as system terminal alternative
    if [[ "$OS_BASE" == "debian" ]] && command -v update-alternatives &>/dev/null; then
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(command -v kitty)" 50 || true
        sudo update-alternatives --set x-terminal-emulator "$(command -v kitty)" || true
    fi
    log "Setting zsh as default..."
    sudo chsh -s "$(command -v zsh)" "$USER"

}


# ========== RUN EVERYTHING ==========
install_general_packages
install_starship
install_neovim
install_nerdfont
install_pyenv
set_defaults

log "✅ Setup complete for $OS_NAME!"

