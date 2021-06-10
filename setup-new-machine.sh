#!/bin/bash

figlet "WARNING!" | lolcat -a -d 2
echo "This will perform a complete setup for a new machine."

while true;
do
    read -p "Are you sure this is what you want to do? [y|n]" yn
    case $yn in
        [Yn]*) break;;
        [Nn]*) exit;;
        *) echo "Please answer y or n";;
    esac
done

setup-shell.sh
setup-dev-tools.sh
setup-apps.sh
customise-spotify.sh
setup-thinkpad-battery.sh
setup-logitech-mouse.sh
setup-keys.sh

figlet "Feels good, man" | lolcat -a -d 2
