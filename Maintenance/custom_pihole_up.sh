#!/bin/bash

if  [[ $EUID -ne 0 ]]; then
	echo "Please run as root user"
	exit 1
else
	echo "Begin PiHole Update ... Please wait"
	pihole -up > /dev/null 2>&1
	echo "PiHole Update Complete ... "
	echo "Update lighttpd Default Port ... "
	sudo sed -i 's/server.port                 = 80/server.port                 = 9000/g'  /etc/lighttpd/lighttpd.conf
	sudo service lighttpd restart
	echo "PiHole Service Rebooted ... "
fi
