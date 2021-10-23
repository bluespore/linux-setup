# linux-setup
Personal configuration scripts for Manjaro linux (Thinkpad X1 Carbon Gen 6)

# Overview 

- Install Manjaro-i3 from live-boot USB
  - root partition, ~50GB EXT4 FS, start of drive
  - home partition, size is what ever is left after root and swap are taken into account, EXT4/LUKS encrypted FS
    - NB. LUKS will require password on system boot
  - swap partition, ~50% of RAM, not really used with SSDs
- Run install script from repo

# Install script

```shell
$(cd ~/Downloads && wget --no-cache https://raw.githubusercontent.com/bluespore/linux-setup/main/install.sh && chmod +x install.sh) && sudo -u `whoami` ~/Downloads/install.sh; rm install.sh; source ~/.bash_profile;
```

## Resume bluetooth after sleep

Script: ./new/bluetooth-resume
Destination: /lib/systemd/system-sleep
Perm: chmod a+x
Comments: Will just work by itself

## Bt headset profile toggle

Script: ./new/toggle-headset-profile 
Destination: ~/.local/bin/toggle-headset-profile
Alias: hs
Perm: chmod a+x
Comments: Exec with 'hs' in shell. Could be tied to hooks, rofi or otherwise.

## Bak script

Script: ./new/backup-packages
Destination: ~/.local/bin/backup-packages 
Perm: chmod a+x
Comments: package list backup script, to be run periodically (boot) 

## Display setup 

Script: ./new/autorandr-config 
Destination: ~/bin/autorandr-config 
Perm: chmod a+x 
Comments: Run with i3 config, ensures external display is detected and the appropriate xrandr config is loaded via autorandr 

## Structure

- `~/.local/bin` created for personal scripts, and found in path
- `~/code` for anything programming, grouped then by company/purpose name
- `~/work` for any documents related to work 
- `~/screenshots` for flameshot / peek saves
- `~/.npm-global` created for global npm installs, set up by zshrc env var
- `~/.n` created for node versions to be called via `n`
- `~/.bak` store periodic lists of packages (npm, pacman, aur) for later install
- `~/.linux-setup` this repo that bootstraps and binds all much of the process


## Keybinds etc  

TODO: Note about the common keybinds

All managed via the i3 config, and should transfer across systems easily now

- Shift+Ctrl+4 - take screenshot with flameshot
- Mod+Shift+p - Power menu

## Auto mount back-up SD card on boot

Modify `fstab` (filesystem table) under `/etc/fstab` 

```
UUID=7c4f6a75-32a2-4f2f-820c-65e85b9969e0 /mnt/backup-sd ext4    auto,nofail,noatime,rw,user 0 0
```

## System conf files 

- 20-intel.conf => `/etc/X11/xorg.conf.d/20-intel.conf`
- 40-libinput.conf => `/usr/share/X11/xorg.conf.d/40-libinput.conf`
- TODO: bluetooth resume location 

## Backups 

- backintime automatically creates a backup of `/home` every boot/reboot on `/mnt/backup-sd/backintime-manjaro`
- timeshift automatically creates snapshots of the system every night on `/mnt/backup-sd/timeshift` 
