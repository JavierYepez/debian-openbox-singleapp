#!/bin/bash
# ACTION: Add Debian repositories contrib and non-free
# INFO: Contrib and non-free repositories are not enabled by default in Debian install
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

cp -v "$base_dir/sources.list" "/etc/apt/sources.list"

# Update and install packages
apt-get update  
