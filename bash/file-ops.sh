#!/usr/bin/env bash
# File operations — safe deletion, backup, directory size.

backup() {
    local src="$1"
    local dest="${2:-${src}.bak}"
    if [ -f "$src" ]; then
        cp "$src" "$dest"
        echo "Backed up $src → $dest"
    elif [ -d "$src" ]; then
        cp -r "$src" "$dest"
        echo "Backed up $src/ → $dest/"
    else
        echo "Not found: $src"
        return 1
    fi
}

dirsize() {
    du -sh "${1:-.}" | cut -f1
}

count_files() {
    find "${1:-.}" -type f | wc -l
}
