#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -f
sudo apt autoremove -y

sudo apt install curl
sudo apt install git
sudo apt install nginx
sudo apt install stow
sudo apt install tree
