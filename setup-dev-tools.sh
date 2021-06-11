#!/bin/bash

figlet "Setup dev tools" | lolcat -a -d 2

echo "Installing cmake libevdev-dev libudev-dev libconfig++-dev..." | lolcat
sudo apt install cmake libevdev-dev libudev-dev libconfig++-dev

echo "Installing vim..." | lolcat
sudo apt install vim

echo "Installing npm..." | lolcat
sudo apt-get install npm

echo "Installing vercel..." | lolcat
sudo npm i -g vercel

echo "Installing rustlang..." | lolcat
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing beekeeper-studio..." | lolcat
sudo snap install beekeeper-studio

echo "Installing spacevim..." | lolcat
curl -sLf https://spacevim.org/install.sh | bash
echo "SpaceVim config files located at \n\t~/.SpaceVim/init.vim\n\t~/.SpaceVim.d/init.toml"

echo "Creating code directory" | lolcat
mkdir -p ~/code
echo "~/code created" | lolcat 
