#!/usr/bin/env bash
#
# ANSI terminal helpers — every function writes to stdout.
# Source this file  (`. ./colors.sh`)  then call the helpers.
#

reset='\033[0m'

info()    { printf '\033[0;34m[INFO]%s %s\n' "$reset" "$*"; }
success() { printf '\033[0;32m[ OK ]%s %s\n' "$reset" "$*"; }
warn()    { printf '\033[1;33m[WARN]%s %s\n' "$reset" "$*"; }
error()   { printf '\033[0;31m[ERR]%s %s\n' "$reset" "$*" >&2; }
header()  { printf '\033[1;36m=== %s ===%s\n' "$*" "$reset"; }
