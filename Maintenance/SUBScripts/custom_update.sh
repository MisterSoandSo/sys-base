#!/bin/bash

LOGFILE="system_update-$(date +%Y-%m-%d-%H%M%S).log"

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo -ne "Status: Update the local package index ...\r"
sudo apt update >>$LOGFILE 2>&1
echo -ne "Status: Upgrading installed packages   ...\r"
sudo apt full-upgrade -y >> $LOGFILE 2>&1
echo -ne "Status: Cleaning up unused packages    ...\r"
sudo apt autoremove >> $LOGFILE 2>&1
echo -ne "Status: Clearing package manager cache ...\r"
sudo apt clean >> $LOGFILE 2>&1

echo -ne "Update complete. Log saved: ${LOGFILE} \n"


