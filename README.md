# linux-setup
Personal configuration scripts for Manjaro linux (Thinkpad X1 Carbon Gen 6)

# Overview 

- Install Manjaro-i3 from live-boot USB
  - root partition, ~50GB EXT4 FS, start of drive
  - home partition, size is what ever is left after root and swap are taken into account, EXT4/LUKS encrypted FS
    - NB. LUKS will require password on system boot
  - swap partition, ~50% of RAM, not really used with SSDs
- Run install script from repo
  - runs mkdir 
  - sys updates, base-devel and git
  - git clone linux-setup to ~/.linux-setup
  - chsh
  - rsync scripts (home OK, system TODO)
  - pacman, aur & npm installs (must be done after rsync, due to npmg install dir configured in zshrc)
  - fix perms on i3lock
  - autocpu-freq

## Install steps

type | cmd | desc
--- |--- | ---
scripted | `mkdir -p ~/.bak ~/code ~/work ~/screenshots ~/.npm-global ~/.n ~/.local/bin ~/.bluespore-linux-setup` | dir structure
scripted | `sudo pacman -Syyu` | upgrade system and packages
scripted | `sudo pacman -S --noconfirm yay` | install yay for AUR packages
scripted | `sudo pacman -S --noconfirm git base-devel` | required tools to build upon others for system setup
scripted | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended` | install ohmyzsh
scripted | `chsh -s $(which zsh) $(whoami)` | change default shell to zsh`
scripted | `git clone git@github.com:bluespore/linux-setup.git ~/.bluespore-linux-setup`
manual | `reboot` | possibly need to reboot, log back in before continuing
scripted | `echo "prefix=/home/$(whoami)/.npm-global" >> ~/.npmrc` | ensure new global npm install location is registered
scripted | `~/.bluespore-linux-setup/cp-home && ~/.bluespore-linux-setup/cp-system` | cp relevant files to their system destinations
scripted | `~/.local/bin/packages-install` | install global node module packages & remaining system packages (pacman/aur)
scripted | `TBD` | fix screen tearing with `20-intel.conf`
scripted | `TBD` | natural scrolling with `40-liblinput.conf`
scripted | `TBD` | autocpu-freq for thinkpad battery optimisation (installed with pacman, setup with `systemctl enable auto-cpufreq`)
scripted | `TBD` | fix permissions for i3lock
scripted | `TBD` | resume bluetooth after sleep via `/lib/systemd/system-sleep/bluetooth-resume`

# new 

## Scripts to run every boot 

```sh
npm list -g --depth 0 | tr -d "├── " | grep -v "/home" | grep -v -e "^$" > ~/.bak/npmgbak
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

## Backups 

- backintime automatically creates a backup of `/home` every boot/reboot on `/mnt/backup-sd/backintime-manjaro`
- timeshift automatically creates snapshots of the system every night on `/mnt/backup-sd/timeshift` 

## Blur lock fix

https://github.com/i3/i3lock/issues/119#issuecomment-643602565

`sudo chmod 4755 "$(which unix_chkpwd)"`

This means it's checking the _correct password_ when it blurs and you have to log in
