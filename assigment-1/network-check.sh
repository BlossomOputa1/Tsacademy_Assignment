#!/bin/bash
# Network Check Script
#Argument extraction and validation
host="$1"
if [ -z "$host" ]; then
    echo "Error: host argument is missing. Usage: $0 <host> [port]" >&2
    exit 1
fi
#host resolution
resolved_address=$(getent hosts "$host" | awk '{print $1}' | head -n 1)
if [ -z "$resolved_address" ]; then
    echo "Error: Unable to resolve host '$host'." >&2
    exit 1
fi
echo "Resolved address: $resolved_address"
#basic connectivity check
echo "Checking connectivity to $host"
if ping -c 2 -W 2 "$host" > /dev/null 2>&1; then
    echo "ICMP Ping was successful."
else
    echo "ICMP PIng failed."
fi
#displaying the network information
echo "showing local network interfaces"
ifconfig addr show
#TCP Port Check 
nc -zw 3 "$host" "$PORT"

echo "$(date) - Network-check.sh executed succesfully" >> logs/network-check.log
