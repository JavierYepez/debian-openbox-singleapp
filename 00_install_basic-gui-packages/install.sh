#!/bin/bash
# ACTION: Install some basic GUI packages
# INFO: Debian netinstall comes with few list of GUI installed packages
# INFO: Some basic packages are: vlc gmtp mtp-tools synaptic galternatives evince
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install free packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y vlc chromium firmware-linux-nonfree

# Add flag for chromium
cat > /etc/chromium.d/ignore-gpu-blocklist <<EOF
export CHROMIUM_FLAGS="\$CHROMIUM_FLAGS --ignore-gpu-blocklist"
EOF