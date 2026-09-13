#!/bin/bash
# app.sh - Assignment 3 Bash Application
if [ "$#" -lt 1 ]; then
    echo "Error: No command was provided. Please provide a command to execute."
    exit 2
fi
Command="$1"
shift 

case "$Command" in
# help 
    help)
        echo "Usage: $0 <command> [arguments]"
        echo "Available commands:"
        echo " System Information --------- This displays the system information  "
        echo " check-port <host> <port> --- This checks if a specific port on a host is open or closed"
        echo " check-host <host> --------- This checks if a specific host is reachable"
        echo " help ---------------------- This displays this help message"
        exit 0
        ;;
# system-info
    system-info)
        echo "===== System Information ====="
        echo "Hostname: $(hostname)"
        echo "Current User: $(whoami)"
        echo "Current Date/Time: $(date)"
        echo "OS: $(uname -s)"
        echo "Operation System: $(uname -smr)"
        echo "Uptime: $(uptime -p)"
        exit 0
        ;;

# check-port <host> <port>
    check-port)
        if [ "$#" -lt 2 ]; then 
            echo "Error: Missing arguments: Host and port required"
            exit 2
        fi
        Host="$1"
        Port="$2"
        if ! [[ "$Port" =~ ^[0-9]+$ ]] || (( Port < 1 || Port >65535 )); then
            echo "Error: Invalid port number: $Port"
            exit 2
        fi
        if nc -z -w 3 "$Host" "$Port" >/dev/null 2>&1; then
            echo "Port $Port on $Host is open"
            exit 0
        else
            echo "Port $Port on $Host is closed"
            exit 1
        fi
        ;;
# check-host <host>
    check-host)
        if [ "$#" -lt 1 ]; then 
            echo "Error: Missing argument: Host required"
            exit 2
        fi
        host="$1"
        if ping -c 1 -W 2 "$host" > /dev/null 2>&1; then
            echo "host $host is reachable"
        else
            echo "host $host is not reachable"
            exit 1
        fi
        ;;
    *)
        echo "Error: Invalid command: $Command"
        echo "Available commands: system-info, check-port, check-host, help"
        exit 2
        ;;

esac