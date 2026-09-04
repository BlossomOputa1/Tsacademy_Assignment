#!/bin/bash
# Disk Check Script
# argument handling
Target_path=${1:-/}
Threshold=${2:-80}
# input validation
if [ ! -d "$Target_path" ]; then 
    echo "Error: $Target_path i snot an available directory" >&2
    exit 2
fi
# is the threshold a valid number
if ! [[ "$Threshold" =~ ^[0-9]+$ ]] || [ "$Threshold" -lt 1 ] || [ "$Threshold" -gt 100 ]; then
echo "Error: Threshold must be an integer between 1 and 100. Received: '$Threshold'" >&2
exit 2
fi

# extracting the disk usage information
Disk_usage=$(df -P "$Target_path" | awk 'NR==2 {print $5} ' | tr -d '%')
# conditional logic with exit codes
if [ "$Disk_usage" -ge "$Threshold" ]; then
    echo "warning: Disk usage has reached or exceeded the threshold!" >&2
    exit 1
else
    echo "Disk usage is less than the Threshold"
    exit 0
fi