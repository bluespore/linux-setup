# linux-setup
Personal configuration scripts for linux laptop

## Install locally

```shell
$(cd ~/Downloads && wget --no-cache https://raw.githubusercontent.com/bluespore/linux-setup/main/install.sh && chmod +x install.sh) && sudo -u `whoami` ~/Downloads/install.sh; rm install.sh; source ~/.bash_profile;
```

# new 

## Resume bluetooth after sleep

Script: ./new/bluetooth-resume
Destination: /lib/systemd/system-sleep
Perm: chmod a+x
Comments: Will just work by itself

## Bt headset profile toggle

Script: ./new/hs 
Destination: ~/bin/hs
Perm: chmod a+x
Comments: Exec with 'hs' in shell. Could be tied to hooks, rofi or otherwise.

## Structure

- `~/bin` created for personal scripts, and found in path
- `~/code` for anything programming, grouped then by company/purpose name
- `~/work` for any documents related to work 
- `~/screenshots` for flameshot / peek saves
- `~/.npm-global` created for global npm installs, set up by zshrc env var
- `~/.n` created for node versions to be called via `n`

## Keybinds etc 

All managed via the i3 config, and should transfer across systems easily now

- Shift+Ctrl+4 - take screenshot with flameshot
- Mod+Shift+p - Power menu

## Auto mount back-up SD card on boot

Modify `fstab` (filesystem table) under `/etc/fstab` 

```
UUID=7c4f6a75-32a2-4f2f-820c-65e85b9969e0 /mnt/backup-sd ext4    auto,nofail,noatime,rw,user 0 0
```

## System conf files 

- ./new/20-intel.conf => `/etc/X11/xorg.conf.d/20-intel.conf`
- ./new/40-libinput.conf => `/usr/share/X11/xorg.conf.d/40-libinput.conf`
