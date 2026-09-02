#!/bin/bash

# to check the system information
# to check the hostname
hostname=$(hostname)
echo "The  hostname of this system is $hostname"

# to check current user
current_user=$(whoami)
echo "the current user of this system is $current_user"
#to display the date/time
current_date_time=$(date)
echo "the curent date/time is $current_date_time"
# to check the operating system
op_system=$(uname -o)
echo "the operationg system of this system is $op_system"
# to check the kernel version
kernel_version=$(uname -r)
echo " the kernel o=version of this system is $kernel_version"
# to check the uptime  fo the system
uptime_info=$(uptime -p)
echo "the uptime of this system is $uptime_info"
# to check the CPU information
cpu_info=$(lscpu -ae)
echo "the CPU information of this system is $cpu_info"
# to check the current working directory
working_directory=$(pwd)
echo "the current working directory of this system is $working_directory"