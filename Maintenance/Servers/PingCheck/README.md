# Custom Ping Script
This a custom bash ping script that takes in a list of ip address from a file.
The script will check and update the ip address file and remove '\r' if the file is generated from a DOS environment.
The script will exit if a file is not provided in the arguments

## Usage
```
#Give script execution permission
chmod +x custom_ping.sh

./custom_ping.sh list.txt
```

## Expected Output

```
Sat Aug 27 13:00:00 PDT 2022
Device: 192.168.0.22 is online
Device: 192.168.0.23 is online
Device: 192.168.0.28 is online
Device: 192.168.0.117 is online
```
