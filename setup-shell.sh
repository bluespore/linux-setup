#!/bin/bash

figlet "Setup shell" | lolcat -a -d 2

echo "Remember to set your default shell to /bin/zsh in Konsole!" | lolcat

echo "Installing build-essential, curl, file & git"
sudo apt-get install build-essential curl file git

echo "Installing zsh..."
sudo apt install zsh
chsh -s $(which zsh)
/bin/bash -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/x19/.zprofile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
echo 'PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"' >> ~/.zshrc
source ~/.zshrc

echo "Installing fzf..."
brew install fzf
$(brew --prefix)/opt/fzf/install
source ~/.zshrc

echo "Installing zoxide..."
brew install zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
source ~/.zshrc

echo "Installing ripgrep..."
sudo apt-get install ripgrep

echo "Installing gcc..."
brew install gcc

echo "Installing neofetch..."
sudo apt install neofetch

echo "Installing xclip..."
sudo apt-get install -y xclip
echo 'alias pbcopy="xclip -sel clip"' >> ~/.zshrc
source ~/.zshrc
echo "Alias 'pbcopy' set to mimic functionality with xclip"

