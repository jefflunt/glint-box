#!/bin/bash

function removePythonGames() {
  if [ -d "$PIHOME/python_games" ]; then
     rm -f "$PIHOME/python_games"
  fi  
}

function removeUnnecessaryPackages() {
  # This is things like:
  # - X11 desktop
  # - python
  # - compilers
  # - extra locales
  # - extra documentation
  # - manpages
  sudo apt-get -y remove `sudo dpkg --get-selections | grep -v "deinstall" | grep x11 | sed s/install//`
  sudo apt-get -y remove x11-common midori lxde python3 python3-minimal lxde-common lxde-icon-theme omxplayer gcc-4.4-base:armhf gcc-4.5-base:armhf gcc-4.6-base:armhf libraspberrypi-doc xkb-data fonts-freefont-ttf locales manpages
}

function removeCodeSamples() {
  sudo rm -rf /opt
}

function removeDeveloperPackages() {
  sudo apt-get -y remove `sudo dpkg --get-selections | grep "\-dev" | sed s/install//`
}

function replaceSshWithDropbear {
  # See: https://matt.ucc.asn.au/dropbear/dropbear.html
  sudo apt-get -y remove `sudo dpkg --get-selections | grep -v "deinstall" | grep ssh | sed s/install//`
  sudo apt-get -y install dropbear
}

function deleteLogFiles() {
  sudo rm -rf `find /var/log/ . -type f`
}

function zeroOutSwapFile() {
# a swapfile is not a swap partition, so no using swapon|off from here on, use  dphys-swapfile swap[on|off]  for that
#disapble swapping and fill swap with zeros
#$SWAPOFF -a
  sudo dphys-swapfile swapoff
  sudo dd if=/dev/zero of=/var/swap bs=1M count=100
}

################
# Script steps #
################

removePythonGames
removeUnnecessaryPackages
removeCodeSamples
removeDeveloperPackages
replaceSshWithDropbear
aptGetCleanup
deleteLogFiles
zeroOutSwapFile
