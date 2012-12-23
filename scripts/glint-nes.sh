#!/bin/bash

PIHOME="/home/pi"
RETROARCH_CONFIG="$PIHOME/retroarch/.config"

function installCurl() {
  echo ""
  echo "## (re-)Installing curl..."
  
  # This must be reinstalled, because it's removed by the clean-pi.sh script
  sudo apt-get -y install curl
}

function addCertificatesForRetroarchBinaries() {
  echo ""
  echo "## Adding certificates and apt sources for retroarch..."
  
  sudo apt-get -y install ca-certificates libxv1
  echo "deb http://archive.changeover.za.net/raspbian wheezy main" > changeover.list
  sudo mv changeover.list /etc/apt/sources.list.d/
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
}

function aptGetUpdateAndUpgrade() {
  echo ""
  echo "## Updating apt..."
  
  # DON'T call this function BEFORE the addition of the apt-key for retroarch binary, otherwise it will break
  sudo apt-get -y update
  sudo apt-get -y upgrade
}

function installFceuAndRetroarch() {
  echo ""
  echo "## Installing retroarch and fceu..."
  
  sudo apt-get -y install libretro-fceu retroarch
  
  mkdir -p $RETROARCH_CONFIG
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/retroarch.cfg > $RETROARCH_CONFIG/retroarch.cfg  
}

function copyUserAndRPiConfigFiles() {
  echo ""
  echo "## Copying user and RPi config files..."
  
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/.profile > ~/.profile
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/raspberry-pi-config.txt > /tmp/config.txt
  sudo mv /boot/config.txt /boot/config.txt.backup
  sudo mv /tmp/config.txt /boot/config.txt
}

function makeGlintLogFolder() {
  echo ""
  echo "## Creating log folder for glint project..."
  
  sudo mkdir -p /var/log/glint
  sudo chown pi:pi /var/log/glint
}

function setupAutoLogin() {
  echo ""
  echo "## Setting up auto-login..."
  
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/scripts/inittab > /tmp/inittab
  sudo mv /etc/inittab /etc/inittab.backup
  sudo mv /tmp/inittab /etc/inittab
}

function setupGlintES() {
  sudo apt-get -y install build-essential libsdl1.2-dev libboost-filesystem-dev libfreeimage-dev libfreetype6-dev
  mkdir -p $PIHOME/glint-es
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/bin/glint-es > $PIHOME/glint-es/glint-es
  chmod +x $PIHOME/glint-es/glint-es

  mkdir -p $PIHOME/.glint-es
  mkdir -p $PIHOME/roms/
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_systems.cfg > $PIHOME/.glint-es/es_systems.cfg
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_theme.xml > $PIHOME/.glint-es/es_theme.xml

  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-font.ttf > $PIHOME/glint-font.ttf
  sudo mv $PIHOME/glint-font.ttf /usr/share/fonts/glint-font.ttf
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-nes-bg.png > $PIHOME/.glint-es/glint-nes-bg.png
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-nes-fsbox-bg.png > $PIHOME/.glint-es/glint-nes-fsbox-bg.png
}

# Currently disabled
#function setupCustomSplashScreen() {
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
#}

# Currently disabled
#function setupUSBMounting() {
  # USB drive support for easy ROM loading
  # apt-get -y install udev autofs
  # mkdir -p /mnt/usbdisk
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/udev-custom.rules > /etc/udev/rules.d/00-custom.rules
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/auto.master > /etc/auto.master
  # curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/auto.master > /etc/auto.ext-usb
  # 
  # /etc/init.d/udev restart
  # /etc/init.d/autofs restart
#}

function setupAudioModules() {
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/modules > $PIHOME/modules
  sudo mv $PIHOME/modules /etc/modules
}

function reinstallMediaLibraries() {
  sudo apt-get -y remove libraspberrypi0
  sudo apt-get -y install libraspberrypi0
}

#######################
# Actual build script #
#######################

echo "############################################"
echo "Running glint-nes/glint-es install script..."
echo "############################################"

# Emulation core
installCurl
addCertificatesForRetroarchBinaries
aptGetUpdateAndUpgrade
installFceuAndRetroarch

copyUserAndRPiConfigFiles

# glint-nes/glint-es setup
makeGlintLogFolder
setupAutoLogin
setupGlintES
#setupCustomSplashScreen
#setupUSBMounting
setupAudioModules
reinstallMediaLibraries
