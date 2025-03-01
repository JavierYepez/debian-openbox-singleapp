#!/bin/bash
# ACTION: Install Micromamba
# INFO: Install Micromamba package manager
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


echo -e "\e[1mInstalling micromamba...\e[0m"

IFS=':'
while read -r user pass uid gid desc home shell; do
  if [ "$shell" != "/bin/bash" ]; then
    continue
  fi
  echo "Installing Micromamba for '$user' with shell '$shell'"

  runuser -l "$user" -c "'$shell' <(curl -L micro.mamba.pm/install.sh)"
done </etc/passwd