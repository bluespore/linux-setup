#!/bin/bash

figlet "Setup dev tools" | lolcat -a -d 2

echo "Installing cmake libevdev-dev libudev-dev libconfig++-dev..."
sudo apt install cmake libevdev-dev libudev-dev libconfig++-dev

echo "Installing vim..."
sudo apt install vim

echo "Installing npm..."
sudo apt-get install npm

echo "Installing vercel..."
sudo npm i -g vercel

echo "Installing rustlang..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing beekeeper-studio..."
sudo snap install beekeeper-studio

echo "Installing spacevim..."
curl -sLf https://spacevim.org/install.sh | bash
echo "SpaceVim config files located at \n\t~/.SpaceVim/init.vim\n\t~/.SpaceVim.d/init.toml"

figlet "Git config details"
read -s "Username:\t" git_user
read -s "Email:\t" git_email
echo "Configuring git user ${git_user} (${git_email})..." | lolcat

git config --global user.name "${git_user}"
git config --global user.email "${git_email}"

echo "Creating code directory"
mkdir -p ~/code
echo "~/code created" | lolcat 
