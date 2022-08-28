#!/bin/bash

bpi_hole(){
	echo "====================================="
	sudo bash custom_pihole_up.sh
}

clear
echo "====================================="
echo "Update package repository ..."

sudo apt update > /dev/null 2>&1
echo "====================================="
echo "Full upgrade packages ..."
sudo apt full-upgrade -y > /dev/null 2>&1

#Pi-Hole users - enable if installed
bpi_hole

#Remove depreciated packages
echo "====================================="
echo "Cleaning packages and cache ..."

sudo apt autoremove > /dev/null 2>&1
#Clean package archive cache
sudo apt clean > /dev/null 2>&1
echo "====================================="
echo "Done ..."


