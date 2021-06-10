#!/bin/bash

figlet "Setup keys" | lolcat -a -d 2

echo "ssh-keygen running, follow the prompts and use no password if you prefer"
ssh-keygen -t rsa
echo "Key generated at ~/.ssh/id_rsa.pub" | lolcat
echo "Browser will open with key in clipboard, so you can add it to your Github account"
pbcopy < ~/.ssh/id_rsa.pub
firefox https://github.com/settings/keys
