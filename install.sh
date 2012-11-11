#!/bin/bash

# Update pi user's profile, Raspberry Pi config file, and auto-login inittab
curl -L https://raw.github.com/normalocity/glint-nes/master/.profile > ~/.profile
curl -L https://raw.github.com/normalocity/glint-nes/master/raspberry-pi-config.txt > /tmp/config.txt
sudo mv /tmp/config.txt /boot/config.txt

curl -L https://raw.github.com/normalocity/glint-nes/master/inittab > /tmp/inittab
sudo mv /tmp/inittab /etc/inittab

# Update the root ca-certificates and the already installed packages
sudo apt-get -y install ca-certificates

# Download retroarch binaries - from http://superpiadventures.com/2012/08/retroarch-packages-for-raspbian/#comment-48
echo "deb http://archive.changeover.za.net/raspbian wheezy main" | sudo tee /etc/apt/sources.list.d/changeover.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF

# DON'T move this line to anyplace BEFORE the addition of the apt-key
sudo apt-get -y update
sudo apt-get -y upgrade
# end DON'T

# Install RetroArch binaries
sudo apt-get -y install libretro-fceu retroarch

# Custom splash screen stuff - disabled for now because it's unstable
# From: http://raspberrypi.stackexchange.com/questions/1214/how-to-add-custom-loading-screen
# sudo apt-get -y install fbi
# curl -L https://raw.github.com/normalocity/glint-nes/master/glint-nes-splash.png > /tmp/splash.png
# sudo mv /tmp/splash.png > /etc/splash.png
# 
# curl -L https://raw.github.com/normalocity/glint-nes/master/glint-splash > /tmp/glint-splash
# sudo mv /tmp/glint-splash /etc/init.d/aaasplash
# 
# sudo chmod a+x /etc/init.d/aaasplash
# sudo insserv /etc/init.d/aaasplash

# Create config file for running RetroArch
mkdir -p ~/.config/retroarch/
cd ~/.config/retroarch/
curl -L https://raw.github.com/normalocity/glint-nes/master/retroarch.cfg > retroarch.cfg

# Cleanup after yourself
sudo apt-get autoremove
sudo apt-get autoclean

# Reboot
sudo shutdown -r now