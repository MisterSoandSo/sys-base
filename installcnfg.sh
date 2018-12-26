#!/bin/bash

###### Functions

install_tmux()
{
	cp tmux/.tmux.conf ~/
	tmux source-file ~/.tmux.conf
}

install_vim()
{
	 cp vimrc/.vimrc ~/
}

install_all()
{
	install_all
	install_tmux
}

help()
{
	echo Current Commands: -t: install tmux config, -v: install vim configs, -a: install install_all
}
bserror()
{
	echo Unknown Command. Use -h or -help for list of commands.
}

###### Main
while [ "$1" != "" ]; do
    case $1 in
        -t | --tmux )           install_tmux
								exit 1
                                ;;
        -v | --vim )    		install_vim
								exit 1
                                ;;
        -a | --all )    		install_all
								exit 1						
                                ;;
        -h | --help )           help
                                exit 1
                                ;;
        *)          	   		bserror
        						;;        
						
    esac
done