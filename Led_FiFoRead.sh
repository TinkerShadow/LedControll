#!/bin/bash

fifo_name="/dev/pi-blaster"                         # fifo name

trap "rm -f $fifo_name" EXIT                    # set trap to rm fifo_name at exit

[ -p "$fifo_name" ] || mkfifo "$fifo_name"      # if fifo not found, create

exec 3< $fifo_name                              # redirect fifo_name to fd 3
                                                # (not required, but makes read clearer)
while :; do
    if read -r -u 3 line; then                  # read line from fifo_name
        if [ "$line" = 'quit' ]; then           # if line is quit, quit
            printf "%s: 'quit' command received\n" "$fifo_name"
            break
        fi
        printf "%s: %s\n" "$fifo_name" "$line"  # print line read
    fi
done

exec 3<&-                                       # reset fd 3 redirection

exit 0
