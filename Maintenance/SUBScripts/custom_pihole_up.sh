#!/bin/bash

default_port=80

# Only update lighttpd if default port was changed
update_lighttpd(){
	if [ $default_port -ne 80 ]; then
		echo -ne  "Status: Update lighttpd Default Port ...           \r"
		sudo sed -i 's/server.port                 = 80/server.port                 = '${default_port}'/g'  /etc/lighttpd/lighttpd.conf
		sudo service lighttpd restart
	fi
}

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
#Check if user passed a new port other than port port 80
if [[ ! $1 =~ ^[0-9]+$ ]]; then
   echo "Expected integer arguement value from 0 to 65535"
   exit 1
else
	default_port=$1
fi


echo -ne "Status: PiHole downloading update ...\r"
pihole -up > /dev/null 2>&1
update_lighttpd
echo "Status: PiHole Service ... Online        "