#!/usr/bin/env bash
# backup-utils.sh — Backup and archive helper functions
# Usage: source bash/backup-utils.sh

# Create a timestamped backup of a file or directory
backup_path() {
    local src="$1"
    local dest="${2:-.}"
    if [ ! -e "$src" ]; then
        echo "Error: '$src' does not exist." >&2
        return 1
    fi
    local ts
    ts=$(date +"%Y%m%d_%H%M%S")
    local base
    base=$(basename "$src")
    local target="${dest}/${base}_${ts}.bak"
    cp -r "$src" "$target"
    echo "Backup created: $target"
}

# Rotate backups: keep the N most recent, remove older ones
rotate_backups() {
    local pattern="$1"
    local keep="$2"
    local dir="${3:-.}"
    local count
    count=$(ls -1t "$dir"/"$pattern" 2>/dev/null | wc -l)
    if [ "$count" -le "$keep" ]; then
        echo "Nothing to rotate ($count backups, keep $keep)."
        return 0
    fi
    local remove=$((count - keep))
    ls -1t "$dir"/"$pattern" 2>/dev/null | tail -n "$remove" | xargs -d '\n' rm -v
    echo "Rotated: removed $remove old backup(s)."
}

# Dry-run backup with size info
preview_backup_size() {
    local src="$1"
    if [ -f "$src" ]; then
        du -h "$src" | cut -f1
    elif [ -d "$src" ]; then
        du -sh "$src" | cut -f1
    else
        echo "0"
    fi
}
