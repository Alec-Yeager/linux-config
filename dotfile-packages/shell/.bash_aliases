alias ll="ls -alhrt"
alias alcom="WEBKIT_DISABLE_DMABUF_RENDERER=1 alcom"
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
alias resource="source ~/.zshrc"
