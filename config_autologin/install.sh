#!/bin/bash
# ACTION: Auto logs in to user 1000
# INFO: Skips login to user 1000
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

cat $base_dir/logind.conf > /etc/systemd/logind.conf
cat $base_dir/20-quiet-printk.conf > /etc/sysctl.d/20-quiet-printk.conf

# mkdir /etc/systemd/system/getty@tty1.service.d/

user=$(cat /etc/passwd | cut -f 1,3 -d: | grep :1000$ | cut -f1 -d:)

# cat > /etc/systemd/system/getty@tty1.service.d/override.conf <<EOF
# [Service]
# ExecStart=
# ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --skip-login --nonewline --noissue --autologin $user --noclear %I \$TERM
# EOF

# systemctl enable getty@tty1.service 

# Enforce Xorg on GDM
sed -i '/WaylandEnable/c\WaylandEnable = false' /etc/gdm3/daemon.conf

# Autologin
sed -i "/AutomaticLogin =/c\AutomaticLogin = $user" /etc/gdm3/daemon.conf
sed -i "/AutomaticLoginEnable =/c\AutomaticLoginEnable = true" /etc/gdm3/daemon.conf