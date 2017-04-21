#!/bin/sh -e
#
# 20_apt_update.sh
#

TERM=xterm

# Update repositories
sudo apt-get update

#Perform Upgrade
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

# Clean + purgeold/obsoleted packages
sudo apt-get -y autoremove
