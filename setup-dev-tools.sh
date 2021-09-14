#!/bin/bash

figlet "Setup dev tools" | lolcat -a -d 2

echo "Installing cmake libevdev-dev libudev-dev libconfig++-dev..." | lolcat
sudo apt install cmake libevdev-dev libudev-dev libconfig++-dev

echo "Installing neovim..." | lolcat
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get install neovim

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

echo "Installing watchman..." | lolcat
brew install watchman

echo "Installing Docker..." | lolcat
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "Installing transport-https, ca-certificates, etc..." | lolcat
sudo apt-get install apt-transport-https ca-certificates gnupg lsb-release

echo "Installing microk8s..." | lolcat
sudo snap install microk8s --classic

echo "Installing redis..." | lolcat
sudo apt install redis

echo "Installing meld..." | lolcat
sudo apt install meld

echo "Creating code directory" | lolcat
mkdir -p ~/code
echo "~/code created" | lolcat 
