#!/bin/bash

#Output the hash value of a file using sha384 to base64
#All modern browsers support SRI except Internet Explorer

if dpkg -s openssl | grep -q "install ok installed"; then
	echo $1":" >> SRI.txt
	cat $1 | openssl dgst -sha384 -binary | openssl base64 -A >> SRI.txt
	echo >> SRI.txt
else
	echo "Install openssl"
fi