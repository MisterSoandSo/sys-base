#!/bin/bash

#Error checking user input
if [ $# -eq 0 ]
  then
    echo "Missing Argument: Script expects a single file path for list of ip addresss"
    exit
fi

file=$1
convert(){
	sed -i 's/\r//g' "$file";
}

#Only use if you using a text file generated from a DOS system
convert

date
while read -r host; 
do
	 ping -c 1 $host &> /dev/null && echo "Device: $host is online" || echo "Device: $host is offline"
done < $file