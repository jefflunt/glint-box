#!/bin/bash

# Update pi user's profile, and Raspberry Pi config file
curl -L https://raw.github.com/normalocity/glint-nes/master/.profile > ~/.profile
curl -L https://raw.github.com/normalocity/glint-nes/master/raspberry-pi-config.txt > /tmp/config.txt
sudo mv /tmp/config.txt /boot/config.txt

# Update the root ca-certificates
sudo apt-get -y install ca-certificates

# Download retroarch binaries - from http://superpiadventures.com/2012/08/retroarch-packages-for-raspbian/#comment-48
echo "deb http://archive.changeover.za.net/raspbian wheezy main" | sudo tee /etc/apt/sources.list.d/changeover.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
sudo apt-get -y update
sudo apt-get -y upgrade

# Install RetroArch binaries
sudo apt-get -y install libretro-fceu retroarch

# Create config file for running RetroArch
mkdir -p ~/.config/retroarch/
cd ~/.config/retroarch/
curl -L https://raw.github.com/normalocity/glint-nes/master/retroarch.cfg > retroarch.cfg

sudo shutdown -r now