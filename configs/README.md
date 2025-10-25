# Custom Configs

## Terminal Aliases
```bash
source ~/.bashrc
```
> The .bashrc file is a shell script that runs every time you open a new interactive terminal window. It is located in your user's home directory (e.g., ~/.bashrc) and allows you to customize your Bash command-line environment.

---
## Tmux Config and Commands
```bash
tmux source-file ~/.tmux.conf
```
```bash
tmux new -s session_name       # Create a new session named "session_name"
tmux attach -t session_name    # Attach to an existing session
tmux list-sessions             # List all tmux sessions (shortcut: tmux ls)
tmux detach                    # Detach from the current session
tmux list-keys                 # List all key bindings
tmux list-commands             # List all available commands
tmux split-windows             # Split session window
tmux source-file ~/.tmux.conf  # Reload configuration file

```
---
## UFW Helper
```bash
sudo ./firewall.sh	                #Rebuilds UFW using default ports=(...).
sudo ./firewall.sh add 8080	        #Adds TCP port 8080 safely.
sudo ./firewall.sh remove 8080	    #Removes TCP port 8080 safely.
```