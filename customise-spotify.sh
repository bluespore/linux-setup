#!/bin/bash

PREF_PATH="${HOME}/.config/spotify/prefs"

figlet "Customise spotify" | lolcat -a -d 2

sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R

echo "Installing spicetify..."
brew install khanhas/tap/spicetify-cli
spicetify
spicetify backup apply enable-devtool

# replace the prefs_path with the correct spotify location
sed -i "/^prefs_path/c\prefs_path\t\t\t\t= ${PREF_PATH}" ~/.config/spicetify/config.ini

echo "Spicetify enabled!" | lolcat
echo "You can switch themes with: spicetify config color_scheme theThemeNameYouWant"
