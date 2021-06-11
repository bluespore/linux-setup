#!/bin/bash

figlet "Git config details" | lolcat
read -s "Username:" git_user
read -s "Email:" git_email
echo "Configuring git user ${git_user} (${git_email})..." | lolcat

git config --global user.name "${git_user}"
git config --global user.email "${git_email}"
