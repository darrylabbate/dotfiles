#!/usr/bin/env bash

# Set default handlers/programs for file-types
# Dependency: duti (brew install duti)

DUTI_DIR=$HOME/dotfiles/macos/duti

# IINA (media files)
while read -r ext; do
  duti -s com.colliderli.iina "$ext" all
done <"${DUTI_DIR}/iina.txt"

# OpenEmu
while read -r ext; do
  duti -s org.openemu.OpenEmu "$ext" all
done <"${DUTI_DIR}/openemu.txt"

# Sublime Text
while read -r ext; do
  duti -s com.sublimetext.3 "$ext" all
done <"${DUTI_DIR}/sublime.txt"
