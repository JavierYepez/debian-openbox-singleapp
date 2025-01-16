#!/bin/bash
# ACTION: Auto logs in to user 1000
# INFO: Skips login to user 1000
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

mkdir /etc/systemd/system/getty@tty1.service.d/

user=$(cat /etc/passwd | cut -f 1,3 -d: | grep :1000$ | cut -f1 -d:)

cat > /etc/systemd/system/getty@tty1.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --nonewline --noissue --autologin $user --noclear %I \$TERM
EOF
