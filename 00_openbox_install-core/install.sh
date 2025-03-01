#!/bin/bash
# ACTION: Install Openbox WM and essential tools and configs
# INFO: Openbox is a lightweight window manager, but needs some additional tools and configs for make it usable
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y openbox obconf xinit arandr xserver-xorg x11-xserver-utils xinit gdm3 gnome-shell
apt-get install -y network-manager network-manager-gnome 

# Configure xinit
# echo -e "\e[1mSetting xinit configs to all users...\e[0m"
# for d in  /etc/skel/  /root  /home/*/; do
# 	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
    
# 	echo "exec openbox-session" > "$d/.xinitrc"
# done

# Set as default
echo -e "\e[1mSetting as default alternative...\e[0m"
update-alternatives --set x-session-manager /usr/bin/openbox-session
