#!/bin/bash

figlet "Setup shell" | lolcat -a -d 2

echo "Remember to set your default shell to /bin/zsh in Konsole!" | lolcat

echo "Installing build-essential, curl, file & git" | lolcat
sudo apt-get install build-essential curl file git

echo "Installing zsh and ohmyzsh..." | lolcat
sudo apt install zsh
chsh -s $(which zsh) $(whoami)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing homebrew..." | lolcat
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
echo 'PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"' >> ~/.zshrc
echo 'PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"' >> ~/.bash_profile
source ~/.bash_profile

echo "Installing fzf..." | lolcat
brew install fzf
$(brew --prefix)/opt/fzf/install

echo "Installing zoxide..." | lolcat
brew install zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

echo "Installing ripgrep..." | lolcat
sudo apt-get install ripgrep

echo "Installing gcc..." | lolcat
brew install gcc

echo "Installing neofetch..." | lolcat
sudo apt install neofetch

echo "Installing xclip..." | lolcat
sudo apt-get install -y xclip
echo 'alias pbcopy="xclip -sel clip"' >> ~/.zshrc
source ~/.zshrc
echo "Alias 'pbcopy' set to mimic functionality with xclip" | lolcat

