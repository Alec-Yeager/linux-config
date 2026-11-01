# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -v

if [[ -f /etc/os-release ]]; then
    OS_NAME=$(. /etc/os-release && echo "${NAME%% *}")
    export OS_DIR=${HOME}/${OS_NAME}
else
    export OS_DIR=${HOME}/Linux
fi

zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# End of lines added by compinstall

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.zsh_local ]; then
    . ~/.zsh_local
fi

export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim
export TERMINAL=kitty

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

unsetopt auto_remove_slash
setopt HIST_IGNORE_DUPS

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

