#!/bin/bash

# Set the glint-nes branch to pull from on github if it isn't already set
if [ -z "$GLINTNESBRANCH" ]
then
  export GLINTNESBRANCH=master
fi

RETROARCH_CONFIG="$HOME/.retroarch"

function addCertificatesForRetroarchBinaries() {
  echo ""
  echo "## Adding certificates and apt sources for retroarch..."
  echo ""
  
  sudo apt-get -y install ca-certificates libxv1
  echo "deb http://archive.changeover.za.net/raspbian wheezy main" > changeover.list
  sudo mv changeover.list /etc/apt/sources.list.d/
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
}

function aptGetUpdateAndUpgrade() {
  echo ""
  echo "## Updating apt..."
  echo ""
  
  # DON'T call this function BEFORE the addition of the apt-key for retroarch binary, otherwise it will break
  sudo apt-get -y update
  sudo apt-get -y upgrade
}

function installFceuAndRetroarch() {
  echo ""
  echo "## Installing retroarch and fceu..."
  echo ""
  
  sudo apt-get -y install libretro-fceu retroarch
  
  mkdir -p $RETROARCH_CONFIG
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/retroarch.cfg > $RETROARCH_CONFIG/retroarch.cfg  
}

function copyUserAndRPiConfigFiles() {
  echo ""
  echo "## Copying user and RPi config files..."
  echo ""
  
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/.profile > ~/.profile
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/raspberry-pi-config.txt > /tmp/config.txt
  sudo mv /boot/config.txt /boot/config.txt.backup
  sudo mv /tmp/config.txt /boot/config.txt
}

function makeGlintLogFolder() {
  echo ""
  echo "## Creating log folder for glint project..."
  echo ""
  
  sudo mkdir -p /var/log/glint
  sudo chown pi:pi /var/log/glint
}

function setupAutoLogin() {
  echo ""
  echo "## Setting up auto-login..."
  echo ""
  
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/scripts/inittab > /tmp/inittab
  sudo mv /etc/inittab /etc/inittab.backup
  sudo mv /tmp/inittab /etc/inittab
}

function setupGlintES() {
  echo ""
  echo "## Installing glint-es frontend..."
  echo ""
  
  sudo apt-get -y install build-essential libsdl1.2-dev libboost-filesystem-dev libfreeimage-dev libfreetype6-dev
  mkdir -p $HOME/glint-es
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/bin/glint-es > $HOME/glint-es/glint-es
  chmod +x $HOME/glint-es/glint-es

  mkdir -p $HOME/.glint-es
  mkdir -p $HOME/roms/
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_systems.cfg > $HOME/.glint-es/es_systems.cfg
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/es_theme.xml > $HOME/.glint-es/es_theme.xml

  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-font.ttf > $HOME/glint-font.ttf
  sudo mv $HOME/glint-font.ttf /usr/share/fonts/truetype/glint-font.ttf
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-nes-bg.png > $HOME/.glint-es/glint-nes-bg.png
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/media/glint-nes-fsbox-bg.png > $HOME/.glint-es/glint-nes-fsbox-bg.png
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
  echo ""
  echo "## Ensuring audio is setup..."
  echo ""
  
  curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/modules > $HOME/modules
  sudo mv $HOME/modules /etc/modules
}

#######################
# Actual build script #
#######################

echo "############################################"
echo "Running glint-nes/glint-es install script..."
echo "############################################"

# Emulation core
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
