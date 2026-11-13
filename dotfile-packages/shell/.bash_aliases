alias ll="ls -alhrt"
alias gmm="git fetch; git pull; git merge origin/master"
alias gcm="git commit -m"
alias gs="git status"
alias gsw="git switch"
alias gswm="git switch master"
alias gpr="git pull --recurse-submodules && git submodule update --init --recursive"
alias nvconf="nvim ${HOME}/.config/nvim"

if [ -n "$ZSH_VERSION" ]; then
    alias resource="source ~/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    alias resource="source ~/.bashrc"
fi

unspace() {
    local target="${1:-.}"

    _sanitize_name() {
        local name="$1"
        # Spaces and tildes → underscore
        name="${name//[ ~]/_}"
        # Brackets/parens: strip but preserve content with underscores
        name="${name//\[/_}" ; name="${name//\]/_}"
        name="${name//\(/_}" ; name="${name//\)/_}"
        name="${name//\{/_}" ; name="${name//\}/_}"
        # Operators and shell-special: remove outright
        name="${name//\$/}"
        name="${name//\`/}"
        name="${name//\\/}"
        name="${name//|/}"
        name="${name//;/}"
        name="${name//&/}"
        name="${name//>/}"
        name="${name//</}"
        name="${name//\!/}"
        name="${name//\?/}"
        name="${name//\*/}"
        name="${name//\^/}"
        name="${name//\"/}"
        name="${name//\'/}"
        # Collapse multiple underscores into one, strip leading/trailing
        name="${name//__/_}" ; name="${name//__/_}"
        name="${name#_}" ; name="${name%_}"
        printf '%s' "$name"
    }

    if [ -d "$target" ]; then
        local file new_name base dir
        for file in "$target"/*; do
            [ -e "$file" ] || continue
            dir="${file%/*}"
            base="${file##*/}"
            new_name="$(_sanitize_name "$base")"
            [ "$base" = "$new_name" ] && continue
            mv -v -n -- "$file" "$dir/$new_name"
        done
    else
        local new_name base dir
        dir="${target%/*}"
        base="${target##*/}"
        new_name="$(_sanitize_name "$base")"
        [ "$base" = "$new_name" ] && { echo "No changes needed."; return; }
        [ "$dir" = "$base" ] \
            && mv -v -n -- "$target" "$new_name" \
            || mv -v -n -- "$target" "$dir/$new_name"
    fi
}
