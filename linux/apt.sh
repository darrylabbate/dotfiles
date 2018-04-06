#!/usr/bin/env bash

# Update, upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -f

# Some necessary Unix tools
apt-get curl
apt-get git
apt-get stow

# Install Apache web server
apt-get apache2
