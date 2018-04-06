#!/usr/bin/env bash

# Update, upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -f

# Some necessary Unix tools
apt-get stow
apt-get git
