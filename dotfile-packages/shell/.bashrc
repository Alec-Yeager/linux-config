PS1="[\u: \w]$ "

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ll="ls -alrth"
alias resource="source ~/.bashrc"

export EDITOR=nvim
export SUDO_EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export TERMINAL=kitty
export QT_QPA_PLATFORMTHEME=qt6ct

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(starship init bash)"
eval "$(zoxide init bash)"

# Bespoke exports for each machine. Things like CMAKE_PREFIX_PATH
if [ -f ~/.bash_variables ]; then
    . ~/.bash_variables
fi
