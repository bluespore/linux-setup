#!/bin/bash

# Bare bones retrieval of remote scripts for installation on the local machine 

DIR=~/.local/bin

declare -a SCRIPTS=(
    "setup-shell.sh"
    "setup-keys.sh"
    "setup-apps.sh"
    "setup-dev-tools.sh"
    "setup-thinkpad-battery.sh"
    "setup-logitech-mouse.sh"
    "setup-new-machine.sh"
    "customise-spotify.sh"
    "config-git.sh"
)

echo "Installing scripts to '${DIR}'"

sudo apt install curl

mkdir -p "$DIR"

for s in "${scripts[@]}"
do
    echo "installing ${s}"
    path="$dir/$s"
    touch $path
    curl -s https://raw.githubusercontent.com/bluespore/linux-setup/main/${s} > $path
    chmod +x "$path"
done

echo "Scripts should now be available under '${DIR}'"

echo "Installing figlet and lolcat for visual shell output..."

sudo apt-get install lolcat figlet

# Ensure local bin available in path 
# lolcat is available at /usr/games so must be included 
echo "PATH=\"/usr/games:${DIR}:$PATH\"" >> ~/.bash_profile

echo "Install complete!"
echo "Scripts can now referenced in your PATH and can be called directly."
