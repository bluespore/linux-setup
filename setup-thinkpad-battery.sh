#!/bin/bash

figlet "Laptop battery" | lolcat -a -d 2

echo "Installing autocpu-freq..."
sudo snap install auto-cpufreq
sudo auto-cpufreq --install
echo "Installed." | lolcat 
echo "Battery optimisations will now be automatically made via the auto-cpufreq daemon."
echo "For more information: https://github.com/AdnanHodzic/auto-cpufreq"
