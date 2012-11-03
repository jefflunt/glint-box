#!/bin/bash

# Update the root ca-certificates
sudo apt-get -y install ca-certificates

# Download retroarch binaries - from http://superpiadventures.com/2012/08/retroarch-packages-for-raspbian/#comment-48
echo "deb http://archive.changeover.za.net/raspbian wheezy main" | sudo tee /etc/apt/sources.list.d/changeover.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
sudo apt-get -y update
sudo apt-get -y upgrade

# Temporarily commented out - might discard at some point
#sudo apt-get -y dist-upgrade

# Install joystick/joypad binaries

sudo apt-get -y install joystick
js

echo ""
echo ""
echo "***** We're now going to configure your controller."
echo ""
read -p "***** PLUG IT IN NOW and press [Enter] to continue..."
jscal -c /dev/input/js0

# Install RetroArch binaries

sudo apt-get -y install libretro-fceu retroarch

# Create config file for running RetroArch
mkdir -p ~/.config/retroarch/
cd ~/.config/retroarch/
curl -L https://raw.github.com/normalocity/glint-nes/master/retroarch.cfg > retroarch.cfg

# Move back to home directory
cd ~

echo ""
echo ""
echo "***** We will now reboot. But when we come back, run the following command to start retroarch."
echo "retroarch <filename.nes> -c ~/.config/retroarch/retroarch.cfg -v"
echo ""
read -p "***** Press [Enter] to reboot..."

sudo shutdown -r now