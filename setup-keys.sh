#!/bin/bash

figlet "Setup keys" | lolcat -a -d 2

echo "ssh-keygen running, follow the prompts and use no password if you prefer" | lolcat
ssh-keygen -t rsa
echo "Key generated at ~/.ssh/id_rsa.pub" | lolcat
echo "Use pbcopy < ~/.ssh/id_rsa.pub to clipboard your key when you need to use retrieve it."
