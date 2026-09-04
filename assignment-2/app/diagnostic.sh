#! /bin/bash


Command="$1"
if [ "$Command" = "system" ]; then
#system logic
    uname -o
    uname -r
    uptime -p
    free -h
    exit 0
elif [ "$Command" = "network" ]; then
    # Network logic
    if [ -z "$2" ]; then
        echo "Error: Please provide a host as the second argument." >&2
        exit 2
    else
        ./network-check.sh "$2"
        exit $?
    fi
elif [ "$Command" = "disk" ]; then
#disk logic
    df -hT
    exit 0
elif [ "$Command" = "help" ]; then
#help logic
    echo "Usage: $0 {system|network|disk|help}"
    exit 0
else
# invalid command logic
    echo "Invalid command. Please use 'system', 'network', 'disk', or 'help' " >&2
    exit 2
fi