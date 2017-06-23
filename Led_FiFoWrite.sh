#!/bin/bash

fifo_name="/dev/pi-blaster"

# Se non esiste, exit :);
[ -p "$fifo_name" ] || {
    printf "\n Error fifo '%s' not found.\n\n" "$fifo_name"
    exit 1
}

[ -n "$1" ] && 
    printf "%s\n" "$1" > "$fifo_name" || 
    printf "pid: '%s' writing to fifo\n" "$$" > "$fifo_name"

exit 0
