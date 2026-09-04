#!/bin/bash

mkdir -p logs
# Disk Check Script
# argument handling
Target_path="${2:-/}"
Threshold="$1"
# input validation
if [ ! -d "$Target_path" ]; then 
    echo "Error: $Target_path i snot an available directory" >&2
    exit 2
fi
# is the threshold a valid number
if ! [[ "$Threshold" =~ ^[0-9]+$ ]] || [ "$Threshold" -lt 1 ] || [ "$Threshold" -gt 100 ]; then
echo "Error: Threshold must be an integer between 1 and 100. Received: '$Threshold'" >&2
echo "$(date) - ERROR: Invalid threshold value '$Threshold' provided for disk-check.sh" >> logs/disk-check.log
exit 2
fi

# extracting the disk usage information
Disk_usage=$(df -P "$Target_path" | awk 'NR==2 {print $5} ' | tr -d '%')
# conditional logic with exit codes
if [ "$Disk_usage" -ge "$Threshold" ]; then
    echo "warning: Disk usage is ${Disk_usage}% and has reached or exceeded the threshold!" >&2
    echo "$(date) - WARNING: Disk usage on $Target_path is ${Disk_usage}%, exceeding threshold of ${Threshold}%" >> logs/disk-check.log
    exit 1
else
    echo "Disk usage is less than the Threshold"
    echo "$(date) - OK: Disk usage on $Target_path is ${Disk_usage}%, exceeding threshold of ${Threshold}%" >> logs/disk-check.log
    exit 0
fi
