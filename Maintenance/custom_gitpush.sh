#!/bin/bash


printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

#Your Github username ....
USERNAME="";

#Your Github password or personal access token
#DO NOT PUSH this script on any repo! This meant for convience while working on remote.
PASSWORD="";

#Parses the link from git remote -v
variable=$(git remote -v | awk '/push/ {print $2}' )
UPSTREAM=${variable:8}

git push https://$USERNAME:$PASSWORD@$UPSTREAM


