#!/usr/bin/env bash
# app/app.sh - Assignment 3 Bash Application

# Require at least one subcommand argument
if [ "$#" -lt 1 ]; then
  echo "Error: No command provided."
  echo "Usage: $0 <command> [arguments]"
  exit 2
fi

COMMAND="$1"
shift

case "$COMMAND" in
  help)
    echo "Usage: $0 <command> [arguments]"
    echo ""
    echo "Available commands:"
    echo "  system-info               Display basic system information"
    echo "  check-host <host>         Resolve and check host reachability"
    echo "  check-port <host> <port>  Verify TCP connectivity to a port (1-65535)"
    echo "  help                      Show this help message"
    exit 0
    ;;

  system-info)
    echo "=== System Information ==="
    echo "Hostname: $(hostname)"
    echo "Current User: $(whoami)"
    echo "Date/Time: $(date)"
    echo "Kernel: $(uname -r)"
    echo "OS: $(uname -s)"
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
    exit 0
    ;;

  check-host)
    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
      echo "Error: Host argument is required."
      exit 2
    fi
    HOST="$1"

    # Attempt resolution via getent or nslookup first; fall back to ping
    RESOLVED_IP=$(getent hosts "$HOST" 2>/dev/null | awk '{print $1}' | head -n1)
    if [ -n "$RESOLVED_IP" ]; then
      echo "Host $HOST resolved to $RESOLVED_IP"
      exit 0
    elif ping -c 1 -W 2 "$HOST" >/dev/null 2>&1; then
      echo "Host $HOST is reachable"
      exit 0
    else
      echo "Host $HOST cannot be resolved or reached"
      exit 1
    fi
    ;;

  check-port)
    if [ "$#" -lt 2 ]; then
      echo "Error: Host and port arguments are required."
      exit 2
    fi
    HOST="$1"
    PORT="$2"

    # Port must be numeric and between 1 and 65535
    if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
      echo "Error: Invalid port '$PORT'. Must be an integer between 1 and 65535."
      exit 2
    fi

    # Test TCP connectivity: prefer built-in /dev/tcp, fall back to nc
    if (timeout 2 bash -c "echo > /dev/tcp/$HOST/$PORT") >/dev/null 2>&1; then
      echo "Port $PORT on $HOST is open"
      exit 0
    elif command -v nc >/dev/null 2>&1 && nc -z -w 2 "$HOST" "$PORT" >/dev/null 2>&1; then
      echo "Port $PORT on $HOST is open"
      exit 0
    else
      echo "Port $PORT on $HOST is closed or unreachable"
      exit 1
    fi
    ;;

  *)
    echo "Error: Invalid command '$COMMAND'."
    echo "Available commands: system-info, check-host, check-port, help"
    exit 2
    ;;
esac