#!/bin/bash
# Usage: faketime.sh <ip> <command...>

if [ -z "$1" ]; then
    echo "Usage: $0 <ip> <command...>"
    exit 1
fi

IP="$1"
shift  # remaining args are the command

DC_TIME=$(ntpdate -q "$IP" | awk 'NR==1{print $1, $2}')

if [ -z "$DC_TIME" ]; then
    echo "[-] Failed to get time from $IP"
    exit 1
fi

echo "[*] DC time: $DC_TIME"
echo "[*] Running: faketime -f '$DC_TIME' $@"

sudo faketime -f "$DC_TIME" "$@"
