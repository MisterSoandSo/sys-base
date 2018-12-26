# tmux
Methods of installing custom tmux configs: 
- [Bash script](https://github.com/MisterSoandSo/Personal-Config)
- Linux command line:
	1. Download .tmux.conf and store on home directory
	2. USe the command line `tmux source-file ~/.tmux.conf` to reload configs


Tmux Commands to keep in mind
```
tmux new -s session_name
tmux attach -t session_name
tmux list-sessions
tmux detach

tmux split-window		#vertical
tmux split-window-h		#horizontal

tmux list-keys
tmux list-commands
tmux info
tmux source-file ~/.tmux.conf
```
	