#!/bin/bash

figlet "Configure MX Master" | lolcat -a -d 2

echo "Directory .logiops will be created in home"
mkdir -p ~/.logiops
git clone git@github.com:PixlOne/logiops.git ~/.logiops
$(cd ~/.logiops && mkdir build && cmake .. && make && sudo make install && sudo systemctl enable logid)

echo "Logiops has been installed" | lolcat
echo "Configuration found in /etc/logid.cfg"
echo "Github: https://github.com/PixlOne/logiops"
