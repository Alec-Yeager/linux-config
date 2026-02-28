PS1="[\u: \w]$ "

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ll="ls -alrth"
alias config='/usr/bin/git --git-dir=/home/Vozrazhat/.cfg/ --work-tree=/home/Vozrazhat'

export EDITOR=nvim
export TERMINAL=kitty
export QT_QPA_PLATFORMTHEME=qt6ct
export COLORSCHEME_FOLDER="~/Arch/ColorSchemes/"
export PATH="$PATH:/home/Vozrazhat/.dotnet/tools"
