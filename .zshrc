# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/Vozrazhat/.zshrc'

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# End of lines added by compinstall

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim
export TERMINAL=kitty
export COLORSCHEME_FOLDER="~/Arch/ColorSchemes/"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export QT_QPA_PLATFORMTHEME=qt6ct

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#powerline-daemon -q
#. /usr/share/powerline/bindings/zsh/powerline.zsh
eval "$(starship init zsh)"

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
export PATH="$PATH:/home/Vozrazhat/.dotnet/tools"
source /usr/share/nvm/init-nvm.sh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(direnv hook zsh)"
