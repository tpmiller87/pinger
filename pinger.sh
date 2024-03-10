#!/bin/bash

subnet="$1"

function ctrl_c() {
    exit 1
}

trap ctrl_c INT

if [ -z "$subnet" ]; then
    echo "Usage: $0 <subnet>"
    echo "<subnet> should be the first three octets, e.g. 192.168.1"
    exit 1
fi

for ip in $(seq 1 254); do
    target="$subnet.$ip"
    ping -c 1 -w 1 "$target" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$target"
    fi
done
