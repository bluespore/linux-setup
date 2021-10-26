#!/bin/bash

# Required strcture
mkdir -p ~/.bak \
          ~/code \
          ~/work \
          ~/screenshots \
          ~/.npm-global \
          ~/.n \
          ~/.local/bin

# Update system
sudo pacman -Syyu

# Required packages
sudo pacman -S --noconfirm yay git base-devel

# Ohmyzsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Swap default shell to zsh
chsh -s $(which zsh) $(whoami)

# Clone repo
git clone https://github.com/bluespore/linux-setup.git ~/.linux-setup

# Set .npm-global as default for global npm installs
echo "prefix=/home/$(whoami)/.npm-global" >> ~/.npmrc

# Rsync home
~/.linux-setup/scripts/rsync-home host

# Install pacman, aur & npm global packages 
~/.local/bin/packages-install

# Ensure auto-cpufreq is started, and runs across boots
# https://github.com/AdnanHodzic/auto-cpufreq
systemctl start auto-cpufreq
systemctl enable auto-cpufreq

# Fix lockscreen permissions, so the correct password is 
# being checked when asked to unlock the computer
# https://github.com/i3/i3lock/issues/119#issuecomment-643602565
sudo chmod 4755 "$(which unix_chkpwd)"
