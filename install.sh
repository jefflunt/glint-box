#!/bin/bash

# Update root user's profile, Raspberry Pi config file, and auto-login inittab
curl -L https://raw.github.com/normalocity/glint-nes/master/config/.profile > ~/.profile
curl -L https://raw.github.com/normalocity/glint-nes/master/config/raspberry-pi-config.txt > /tmp/config.txt
mv /boot/config.txt /boot/config.txt.backup
mv /tmp/config.txt /boot/config.txt

curl -L https://raw.github.com/normalocity/glint-nes/master/scripts/inittab > /tmp/inittab
mv /etc/inittab /etc/inittab.backup
mv /tmp/inittab /etc/inittab

# Update the root ca-certificates and the already installed packages
apt-get -y install ca-certificates libxv1

# Download retroarch binaries - from http://superpiadventures.com/2012/08/retroarch-packages-for-raspbian/#comment-48
echo "deb http://archive.changeover.za.net/raspbian wheezy main" | tee /etc/apt/sources.list.d/changeover.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF

# DON'T move this section to anyplace BEFORE the addition of the apt-key for retroarch binary, otherwise it will break
apt-get -y update
apt-get -y upgrade
# end DON'T

# Install RetroArch binaries
apt-get -y install libretro-fceu retroarch

# glint-es dependencies
apt-get -y install build-essential libsdl1.2-dev libboost-filesystem-dev libfreeimage-dev libfreetype6-dev libsdl-mixer1.2-dev
mkdir -p /root/glint-es
curl -L https://raw.github.com/normalocity/glint-nes/master/bin/glint-es > /root/glint-es/glint-es

cd ~
mkdir -p .emulationstation
mkdir -p ~/roms/
curl -L https://raw.github.com/normalocity/glint-nes/master/config/es_systems.cfg > /root/.emulationstation/es_systems.cfg
curl -L https://raw.github.com/normalocity/glint-nes/master/config/es_input.cfg > /root/.emulationstation/es_input.cfg
curl -L https://raw.github.com/normalocity/glint-nes/master/config/es_theme.xml > /root/.emulationstation/es_theme.xml

curl -L https://raw.github.com/normalocity/glint-nes/master/media/glint-font.ttf > /usr/share/fonts/truetype/glint-font.ttf
curl -L https://raw.github.com/normalocity/glint-nes/master/media/glint-nes-bg.png > /root/.emulationstation/glint-nes-bg.png
curl -L https://raw.github.com/normalocity/glint-nes/master/media/glint-nes-fsbox-bg.png > /root/.emulationstation/glint-nes-fsbox-bg.png

# USB drive support for easy ROM loading
apt-get -y install udev autofs
mkdir -p /mnt/usbdisk
curl -L https://raw.github.com/normalocity/glint-nes/master/config/udev-custom.rules > /etc/udev/rules.d/00-custom.rules
curl -L https://raw.github.com/normalocity/glint-nes/master/config/auto.master > /etc/auto.master
curl -L https://raw.github.com/normalocity/glint-nes/master/config/auto.master > /etc/auto.ext-usb

/etc/init.d/udev restart
/etc/init.d/autofs restart

# Custom splash screen stuff - disabled for now because it's unstable
# From: http://raspberrypi.stackexchange.com/questions/1214/how-to-add-custom-loading-screen
# apt-get -y install fbi
# curl -L https://raw.github.com/normalocity/glint-nes/master/glint-nes-splash.png > /tmp/splash.png
# mv /tmp/splash.png > /etc/splash.png
# 
# curl -L https://raw.github.com/normalocity/glint-nes/master/scripts/glint-splash > /tmp/glint-splash
# mv /tmp/glint-splash /etc/init.d/aaasplash
# 
# chmod a+x /etc/init.d/aaasplash
# insserv /etc/init.d/aaasplash

# Create config file for running RetroArch
mkdir -p ~/.config/retroarch/
cd ~/.config/retroarch/
curl -L https://raw.github.com/normalocity/glint-nes/master/config/retroarch.cfg > retroarch.cfg

# Setup audio module
curl -L https://raw.github.com/normalocity/glint-nes/master/config/modules > /etc/modules

# Set 192/64 memory split
cp /boot/arm192_start.elf /boot/start.elf

# Cleanup after yourself
apt-get autoremove
apt-get autoclean

# Reboot
shutdown -r now