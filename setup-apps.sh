#!/bin/bash

figlet "Setup apps" | lolcat -a -d 2

# Recognise Snap-installed apps in krunner
echo 'export PATH="$PATH:/snap/bin"' >> ~/.xprofile
echo 'export PATH="$PATH:/snap/bin"' >> ~/.profile

echo "Installing 1password..." | lolcat
sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo apt update && sudo apt install 1password

echo "Installing vscode..." | lolcat
snap install code --classic

echo "Installing discord..." | lolcat
sudo snap install discord

echo "Installing slack..." | lolcat
sudo snap install slack --classic

echo "Installing chromium..." | lolcat
sudo snap install chromium

echo "Installing flameshot..." | lolcat
sudo apt-get install flameshot

echo "Installing obsidian.md..." | lolcat
cd ~/Downloads; 
curl -O https://github.com/obsidianmd/obsidian-releases/releases/download/v0.12.4/obsidian_0.12.4_amd64.snap 
sudo snap install --dangerous obsidian_0.12.4_amd64.snap
rm obsidian_0.12.4_amd64.snap
cd ~

# Specific version of spotify in order to customise with spicetify
echo "Installing spotify..." | lolcat
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

echo "Installing dropbox..." | lolcat
echo "Dropbox daemon will start after install, configure selective sync, and ensure it runs at start up, then close"
$(cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -)
echo "Run the dropbox daemon to auto-start it when you're ready: ~/.dropbox-dist/dropboxd"

echo "Don't forget plasma-integration for firefox: https://addons.mozilla.org/en-US/firefox/addon/plasma-integration/" | lolcat
