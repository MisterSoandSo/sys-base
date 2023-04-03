#!/bin/bash

#List of ports: 0 to 65535
#Port numbers 0 to 1023 are reserved: 21,22(ssh),23,25,53,80
ports=()
#Set true if your running this script over an ssh connection and no manual access to target machine. 
remote_exec=true


# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if user has initialized their own ports to the script
if [ ${#ports[@]} -eq 0 ]; then
   echo "No port number detected. Ports needed to added to the line eg: ports=("1" "2" "3")"
   exit 1
fi


#UFW Firewall Rules
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing

for port in "${ports[@]}"
do
   sudo ufw allow $port/tcp
   echo "${port} added to ufw rules"
done

#Idiot-proofing the script in-case user decides to lock themselves out of their ssh connection
if $remote_exec; then
   sudo ufw allow ssh
fi

sudo ufw enable
#Command will prompt if your sure you want to reload firewall rules with new rules
sudo ufw reload

#Check status of firewall rules after update
sudo ufw status