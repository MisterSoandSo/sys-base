#!/bin/bash

#Uncomment if you want set local config for a particular repo
#git config --local user.email ""
#git config --local user.name ""

#Your Github username ....
USERNAME="";

#Your Github password or personal access token
#DO NOT PUSH this script on any public repo! This meant for convenience while working on remote.
PASSWORD="";

#Script will exit if the either username or password is empty
if [ -z "$USERNAME" ];
then
	if [ -z ${git_user+x} ]; then echo "git_user is unset"; exit; else USERNAME=$git_user; fi
fi

if [ -z "$PASSWORD" ];
then
	if [ -z ${git_pass+x} ]; then echo "git_pass is unset"; exit; else PASSWORD=$git_pass; fi
fi


#Parses the link from git remote -v
variable=$(git remote -v | awk '/push/ {print $2}' )
UPSTREAM=${variable:8}

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

#git clone https://username:password@github.com/username/repository.git
git push https://$USERNAME:$PASSWORD@$UPSTREAM


