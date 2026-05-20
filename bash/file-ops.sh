#!/usr/bin/env bash
#
# File-system helpers — single-responsibility, no external dependencies.
# Source:  `. ./file-ops.sh`
#

# Back up a file or directory.
backup() {
  local src="$1" dest="${2:-${src}.bak}"
  if [ -f "$src" ]; then
    cp "$src" "$dest" && echo "→ $dest"
  elif [ -d "$src" ]; then
    cp -r "$src" "$dest" && echo "→ $dest/"
  else
    echo "Not found: $src" >&2
    return 1
  fi
}

# Human-readable size of a path.
dirsize() { du -sh "${1:-.}" | cut -f1; }

# Count of files (recursive).
filecount() { find "${1:-.}" -type f | wc -l; }

# Rename file extensions in the current directory.
rename_ext() {
  local from="$1" to="$2"
  for f in *."$from"; do
    [ -f "$f" ] && mv "$f" "${f%.$from}.$to"
  done
}
# Count lines of code recursively.
loc() {
  find "${1:-.}" -type f \( -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.rs" -o -name "*.go" -o -name "*.java" \) -exec cat {} + 2>/dev/null | wc -l
}
# Count lines of code recursively.
loc() {
  find "${1:-.}" -type f \( -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.rs" -o -name "*.go" -o -name "*.java" \) -exec cat {} + 2>/dev/null | wc -l
}
# Count lines of code recursively.
loc() {
  find "${1:-.}" -type f \( -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.rs" -o -name "*.go" -o -name "*.java" \) -exec cat {} + 2>/dev/null | wc -l
}
