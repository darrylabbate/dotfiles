#!/usr/bin/env bash

# Update, upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -f

# Some necessary Unix tools
apt-get install curl
apt-get install git
apt-get install stow
apt-get install tree

# Ruby dependencies
apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Install Apache web server
apt-get install apache2
