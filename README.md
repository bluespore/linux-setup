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
$(cd ~/Downloads && wget --no-cache https://raw.githubusercontent.com/bluespore/linux-setup/main/install.sh && chmod +x install.sh) && sudo -u `whoami` ~/Downloads/install.sh; rm install.sh;
```

# System files 

Manually copy the files you need from `./system` to their relevant location. These steps are 
deliberately not scripted to de-risk the install.

file | dest dir | desc
--- | --- | ---
`20-intel.conf` | `/etc/X11/xorg.conf.d/` | fix screen tearing on Intel integrated graphics
`40-libinput.conf` | `/usr/share/X11/xorg.conf.d/` | adds natural scrolling to touch pad and mouse
`bluetooth-resume` | `/lib/systemd/system-sleep/` | reconnects bluetooth when waking the machine from sleep


# Scripts available in $PATH 

The following scripts are available in `~/.local/bin`

script | desc | alias | exec
--- | --- | --- | ---
`autorandr-config` | detects display setup and configures xrandr via autorandr config | none | auto - i3 boot
`packages-backup` | creates package list files in `~/.bak` for pacman, aur & npm | none | auto - i3 boot
`packages-install` | part of this repo bootstrap, installs packages from the output of a periodic `packages-backup` on the running system | none | can ignore, bootstrap
`styli.sh` | [automatic wallpapers](https://github.com/thevinter/styli.sh) | none | auto - i3, see config
`toggle-headest-profile` | switches bt headset between handsfree & a2dp | `hs` | manual, when going in/out of calls

# Structure

dir | desc
--- | ---
`~/.bak` | store periodic lists of packages (npm, pacman, aur) for later install
`~/.linux-setup` | **this repo install location** that bootstraps and binds all much of the process
`~/.local/bin` | created for personal scripts, and found in path
`~/.n` | created for node versions to be called via `n`
`~/.npm-global` | created for global npm installs, set up by zshrc env var
`~/code` | for anything programming, grouped then by company/purpose name
`~/screenshots` | for flameshot / peek saves
`~/work` | for any documents related to work 

# Notes on keybinds and preferences  

- [ ] TODO: Note about keybinds should be documented via the i3 config file itself

# Backups process 

- [backintime](https://backintime.readthedocs.io/en/latest/) automatically creates a backup of `/home` every boot on the MicroSD card mounted at `/mnt/backup-sd/backintime-manjaro`. Mostly a general backup plan for the home directory, and should make it easier to flip to another distro or machine if needed, as it's own it's own partition.
- [timeshift](https://github.com/teejee2008/timeshift) automatically creates snapshots of the system every day on the MicroSD card mounted at `/mnt/backup-sd/timeshift`. This is used to roll back system profiles in case of system break from updates or otherwise.

## Auto-mounting back-up SD card on boot

We have to script the SD card mount for every boot so that timeshift and backintime have access 
to it for their backup process. UUID might change, but this line gives you the required parameters 
for the line in `/etc/fstab` (filesystem table)

```
UUID=7c4f6a75-32a2-4f2f-820c-65e85b9969e0 /mnt/backup-sd ext4    auto,nofail,noatime,rw,user 0 0
```
