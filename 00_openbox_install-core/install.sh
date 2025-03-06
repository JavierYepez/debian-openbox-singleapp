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
apt-get install -y openbox obconf picom hsetroot arandr xserver-xorg x11-xserver-utils xinit gdm3
apt-get install -y network-manager network-manager-gnome 

echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /home/*/ /root; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

    # Create config folder if no exists
    d="$d/.config"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

    # Create config folders if no exists
    d2="$d"
    d="$d/openbox/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

    # Copy openbox autostart file
    f="autostart.sh"
    cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"

    # Copy picom.conf
    d="$d2/picom/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
    f="picom.conf"
    cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"

done
# Set as default
echo -e "\e[1mSetting as default alternative...\e[0m"
update-alternatives --set x-session-manager /usr/bin/openbox-session
