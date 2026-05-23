#!/usr/bin/env bash
# datetime — Bash date/time formatting utilities
# Usage: source colors.sh && source datetime.sh

# Format current time as ISO-8601
now_iso() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Format current time as readable
now_readable() {
    date +"%A, %d %B %Y %H:%M:%S %Z"
}

# Get Unix timestamp
now_unix() {
    date +%s
}

# Format a given unix timestamp
format_timestamp() {
    local ts=$1
    local fmt=${2:-"%Y-%m-%d %H:%M:%S"}
    date -d "@$ts" +"$fmt" 2>/dev/null || \
    date -r "$ts" +"$fmt" 2>/dev/null || \
    echo "Invalid timestamp: $ts"
}

# Calculate time difference between two timestamps (in seconds)
time_diff() {
    local start=$1
    local end=${2:-$(date +%s)}
    echo $((end - start))
}

# Convert seconds to human readable duration
seconds_to_human() {
    local seconds=$1
    local days=$((seconds / 86400))
    local hours=$(( (seconds % 86400) / 3600 ))
    local mins=$(( (seconds % 3600) / 60 ))
    local secs=$((seconds % 60))
    
    local result=""
    [[ $days -gt 0 ]] && result+="${days}d "
    [[ $hours -gt 0 ]] && result+="${hours}h "
    [[ $mins -gt 0 ]] && result+="${mins}m "
    result+="${secs}s"
    echo "$result"
}

# Validate date string
validate_date() {
    local date_str=$1
    if date -d "$date_str" &>/dev/null || date -j -f "%Y-%m-%d" "$date_str" &>/dev/null 2>&1; then
        echo "valid"
    else
        echo "invalid"
    fi
}

# Get day of week (1=Monday, 7=Sunday)
day_of_week() {
    local date_str=${1:-now}
    date -d "$date_str" +%u 2>/dev/null || date -j -f "%Y-%m-%d" "$date_str" +%u 2>/dev/null || echo "0"
}

# Check if weekend
is_weekend() {
    local day=$(day_of_week "$1")
    [[ "$day" -ge 6 ]]
}

# Human readable elapsed time (like 2h ago)
time_ago() {
    local then=$1
    local now=$(date +%s)
    local diff=$(( now - then ))
    seconds_to_human "$diff"
}
