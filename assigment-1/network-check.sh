#!/bin/bash
# Network Check Script

host="$1"
PORT="$2"

# 1. Host argument validation
if [ -z "$host" ]; then
    echo "Error: host argument is missing. Usage: $0 <host> [port]" >&2
    exit 1
fi

# 2. Optional port validation
if [ -n "$PORT" ]; then
    if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
        echo "Error: Port must be an integer between 1 and 65535. Received: '$PORT'" >&2
        exit 2
    fi
fi

# 3. Host resolution
resolved_address=$(getent hosts "$host" | awk '{print $1}' | head -n 1)
if [ -z "$resolved_address" ]; then
    echo "Error: Unable to resolve host '$host'." >&2
    exit 1
fi
echo "Resolved address: $resolved_address"

# 4. Basic connectivity check
echo "Checking connectivity to $host..."
if ping -c 2 -W 2 "$host" > /dev/null 2>&1; then
    echo "ICMP Ping was successful."
else
    echo "ICMP Ping failed."
fi

# 5. Display local network interfaces
echo "Showing local network interfaces:"
ip addr show

# 6. TCP Port check (only runs if PORT was provided)
if [ -n "$PORT" ]; then
    echo "Checking TCP port $PORT on $host..."
    if nc -zw 3 "$host" "$PORT" > /dev/null 2>&1; then
        echo "TCP Port $PORT is open on $host."
    else
        echo "TCP Port $PORT is closed on $host."
    fi
fi

# 7. Logging
mkdir -p logs
echo "$(date) - network-check.sh executed successfully for $host" >> logs/network-check.log