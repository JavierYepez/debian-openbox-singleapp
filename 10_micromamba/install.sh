#!/bin/bash
# ACTION: Install Micromamba
# INFO: Install Micromamba package manager
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


echo -e "\e[1mInstalling micromamba...\e[0m"
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)