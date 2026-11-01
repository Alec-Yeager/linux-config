PS1="[\u: \w]$ "

if [[ -f /etc/os-release ]]; then
    OS_NAME=$(. /etc/os-release && echo "${NAME%% *}")
    export OS_DIR=${HOME}/${OS_NAME}
else
    export OS_DIR=${HOME}/Linux
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR=nvim
export SUDO_EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export TERMINAL=kitty

eval "$(starship init bash)"
eval "$(zoxide init bash)"

# Bespoke exports for each machine. Things like CMAKE_PREFIX_PATH
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
