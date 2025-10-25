# PingCheck 

A lightweight Bash utility for checking the online status of multiple devices on your network.  
It reads a list of IP addresses or hostnames from a file and reports which ones are reachable.

This updated version includes:
- Automatic cleanup of Windows/DOS line endings
- Optional parallel ("fast") scanning mode
- Configurable ping counts
- Colored output for quick status recognition
- Summary statistics at the end of each run

---

## Usage

```bash
# Make the script executable
chmod +x custom_ping.sh

# Basic usage — sequential scan
./custom_ping.sh list.txt

# Fast mode (runs up to 10 checks in parallel)
./custom_ping.sh list.txt --fast

# Specify number of pings per host
./custom_ping.sh list.txt --count 3
```

---
## File Format
The input file should contain one IP address or hostname per line, for example:
```
192.168.0.22
192.168.0.23
192.168.0.28
192.168.0.117
```
The script automatically removes `\r` carriage returns if the file was generated on Windows.

---
## Expected Output
```
=== Network Scan Started: Sat Oct 24 12:00:00 PDT 2025 ===
Using file: list.txt

[ONLINE]  192.168.0.22
[OFFLINE] 192.168.0.23
[ONLINE]  192.168.0.28
[ONLINE]  192.168.0.117

=== Scan Complete ===
Online:  3
Offline: 1
```