# System Update Bash Scripts
The following scripts are for automatic maintance scripts meant to used on Debain/Raspberrypi systems. Do not forget to give the scripts execute permissions. Also, if you run into LF errors use `sed -i 's/\r//g' script.sh` to remove Windows carriage returns.

## custom_update.sh
This script is a generic update script that pipes all output to a logfile in the same directory. Do note that this script will not handle cases where user is prompted for addition confirmations.
#### WARNING: Use this script with caution as user prompts are not displayed or handled with this script.

## custom_pihole_up.sh
This script is meant allow Pi-Hole to update all core systems while restoring the custom port number for the web admin interface. Default Port is set to port 80. You can modify `default_port=80` to another port value if needed. If use an argument, the script expects an integer port value, anthing else after that will be ignored.

```
#Default
./custom_pihole_up.sh

#Custom
./custom_pihole_up.sh 9000
```

## custom_ufwsetup.sh
This script is used for setting upa basic ufw firewall rules by disabling all incoming traffic except ssh and custom ports on a scalable fashion.
