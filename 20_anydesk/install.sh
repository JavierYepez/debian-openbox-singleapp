#!/bin/bash
# ACTION: Install Anydesk
# INFO: Installs Anydesk for all users
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Add the AnyDesk GPG key
apt update
apt install ca-certificates curl apt-transport-https
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY -o /etc/apt/keyrings/keys.anydesk.com.asc
chmod a+r /etc/apt/keyrings/keys.anydesk.com.asc

# Add the AnyDesk apt repository
echo "deb [signed-by=/etc/apt/keyrings/keys.anydesk.com.asc] https://deb.anydesk.com all main" | tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null

# Update apt caches and install the AnyDesk client
apt update
apt install -y anydesk

sudo systemctl enable --now anydesk.service