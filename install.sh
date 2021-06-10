#!/bin/bash

# Bare bones retrieval of remote scripts for installation on the local machine 

SCRIPT_DIR=~/.local/bin

declare -a SCRIPTS=(
    "setup-shell.sh"
    "setup-keys.sh"
    "setup-apps.sh"
    "setup-dev-tools.sh"
    "setup-displaylink-dock.sh"
    "setup-thinkpad-battery.sh"
    "setup-logitech-mouse.sh"
    "setup-new-machine.sh"
    "customise-spotify.sh"
)

echo "Installing scripts to '${DIR}'"

mkdir -p $DIR

for s in "${SCRIPTS[@}]}"
do
    echo "Installing ${s}"
    path="$DIR/$s"
    touch $path
    curl -s https://raw.githubusercontent.com/bluespore/linux-setup/main/${s} > $path
    chmod +x "$path"
done

echo "Scripts should now be available under '${DIR}'"

echo "Installing figlet and lolcat for visual shell output..."

sudo apt-get install lolcat figlet

# Ensure local bin available in path 
echo "PATH=\"${DIR}:$PATH\"" >> ~/.profile

source ~/.profile

echo "Install complete!" | lolcat 
echo "Scripts can now referenced in your PATH and can be called directly."
