#!/bin/bash

#Dependecy on git
#Pull github repository that holds vimrc
git clone https://github.com/aso001/vimrc.git

#Moving .vimrc to local files and removing .git repo from local files
cd vimrc
mv .vimrc ~/
rm -rf .git
cd ..
rm -r vimrc
clear
exit
