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

# ========== COPY DOTFILES ==========
log "Copying dotfiles..."
cp -r "$TARGET_DIR/linux-config"/.[!.]* "$HOME"/ 2>/dev/null || true

# ========== INSTALL NEOVIM (GLOBAL) ==========
install_neovim() {
    log "Installing Neovim AppImage globally..."
    cd /tmp
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    sudo mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
    sudo chmod +x /opt/nvim/nvim
    sudo ln -sf /opt/nvim/nvim /usr/local/bin/nvim
    cd -
}

# ========== INSTALL STARSHIP ==========
install_starship() {
    log "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
}

# ========== INSTALL Z, ZSH, KITTY, LUAROCKS ==========
install_general_packages() {
    log "Installing kitty, zoxide, zsh, luarocks..."
    eval "$PKG_INSTALL kitty zoxide zsh luarocks" || warn "Some packages may not be found on this distro."
}

# ========== INSTALL NERD FONT ==========
install_nerdfont() {
    log "Installing RobotoMono Nerd Font..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)" <<EOF
43
EOF
}

# ========== INSTALL PYENV ==========
install_pyenv() {
    log "Installing pyenv dependencies for $OS_BASE..."

    case "$OS_BASE" in
        debian)
            sudo apt update
            sudo apt install -y make build-essential libssl-dev zlib1g-dev \
                libbz2-dev libreadline-dev libsqlite3-dev curl git \
                libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
                libffi-dev liblzma-dev
            ;;
        arch)
            sudo pacman -S --needed --noconfirm base-devel openssl zlib xz tk zstd
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
    log "Setting zsh as default..."
    eval "sudo chsh -s $(command -v zsh)"
    log "Setting Kitty as default terminal..."
    # Debian/Ubuntu only: set kitty as system terminal alternative
    if [[ "$OS_BASE" == "debian" ]] && command -v update-alternatives &>/dev/null; then
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(command -v kitty)" 50 || true
        sudo update-alternatives --set x-terminal-emulator "$(command -v kitty)" || true
    fi
}


# ========== RUN EVERYTHING ==========
install_general_packages
install_starship
install_neovim
install_nerdfont
install_pyenv

log "✅ Setup complete for $OS_NAME!"

