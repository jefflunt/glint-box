#!/bin/bash

PIHOME="/home/pi"
RETROARCH_CONFIG="$PIHOME/retroarch/.config"

function addCertificatesForRetroarchBinaries() {
  apt-get -y install ca-certificates libxv1
  echo "deb http://archive.changeover.za.net/raspbian wheezy main" | tee /etc/apt/sources.list.d/changeover.list
  apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
}

function aptGetUpdateAndUpgrade() {
  # DON'T call this function BEFORE the addition of the apt-key for retroarch binary, otherwise it will break
  apt-get -y update
  apt-get -y upgrade
}

function installFceuAndRetroarch() {
  apt-get -y install libretro-fceu retroarch
  
  mkdir -p $RETROARCH_CONFIG
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/retroarch.cfg > $RETROARCH_CONFIG/retroarch.cfg  
}

function copyUserAndRPiConfigFiles() {
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/.profile > ~/.profile
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/raspberry-pi-config.txt > /tmp/config.txt
  mv /boot/config.txt /boot/config.txt.backup
  mv /tmp/config.txt /boot/config.txt
}

function makeGlintLogFolder() {
  mkdir -p /var/log/glint
}

function setupAutoLogin() {
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/scripts/inittab > /tmp/inittab
  mv /etc/inittab /etc/inittab.backup
  mv /tmp/inittab /etc/inittab
}

function setupGlintES() {
  apt-get -y install build-essential libsdl1.2-dev libboost-filesystem-dev libfreeimage-dev libfreetype6-dev
  mkdir -p $PIHOME/glint-es
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/bin/glint-es > $PIHOME/glint-es/glint-es
  chmod +x $PIHOME/glint-es/glint-es

  mkdir -p $PIHOME/.glint-es
  mkdir -p $PIHOME/roms/
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_systems.cfg > $PIHOME/.glint-es/es_systems.cfg
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_input.cfg > $PIHOME/.glint-es/es_input.cfg
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_theme.xml > $PIHOME/.glint-es/es_theme.xml

  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-font.ttf > /usr/share/fonts/truetype/glint-font.ttf
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-nes-bg.png > $PIHOME/.glint-es/glint-nes-bg.png
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-nes-fsbox-bg.png > $PIHOME/.glint-es/glint-nes-fsbox-bg.png
}

function setupCustomSplashScreen() {
  # Currently disabled
  
  # Custom splash screen stuff - disabled for now because it's unstable
  # From: http://raspberrypi.stackexchange.com/questions/1214/how-to-add-custom-loading-screen
  # apt-get -y install fbi
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/glint-nes-splash.png > /tmp/splash.png
  # mv /tmp/splash.png > /etc/splash.png
  # 
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/scripts/glint-splash > /tmp/glint-splash
  # mv /tmp/glint-splash /etc/init.d/aaasplash
  # 
  # chmod a+x /etc/init.d/aaasplash
  # insserv /etc/init.d/aaasplash
}

function setupUSBMounting() {
  # Currently disabled
  
  # USB drive support for easy ROM loading
  # apt-get -y install udev autofs
  # mkdir -p /mnt/usbdisk
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/udev-custom.rules > /etc/udev/rules.d/00-custom.rules
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/auto.master > /etc/auto.master
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/auto.master > /etc/auto.ext-usb
  # 
  # /etc/init.d/udev restart
  # /etc/init.d/autofs restart
}

function setupAudioModules() {
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/modules > /etc/modules
}

function aptGetCleanup() {
  apt-get -y autoremove
  apt-get -y clean
}

#######################
# Actual built script #
#######################

# Emulation core
addCertificatesForRetroarchBinaries
aptGetUpdateAndUpgrade
installFceuAndRetroarch

copyUserAndRPiConfigFiles

# glint-nes/glint-es setup
makeGlintLogFolder
setupAutoLogin
setupGlintES
setupCustomSplashScreen
setupUSBMounting
setupAudioModules
aptGetCleanup
