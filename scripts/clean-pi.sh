#!/bin/bash

function removePythonGames() {
  echo ""
  echo "## Removing python games..."
  echo ""
  
  if [ -d "$PIHOME/python_games" ]; then
     rm -rf "$PIHOME/python_games"
  fi  
}

function removeUnnecessaryPackages() {
  echo ""
  echo "## Removing extra packages..."
  echo ""
  
  # This is things like:
  # - X11 desktop
  # - python
  # - compilers
  # - extra locales
  # - extra documentation
  # - manpages
  sudo apt-get -y remove `sudo dpkg --get-selections | grep -v "deinstall" | grep x11 | sed s/install//`
  sudo apt-get -y remove x11-common midori lxde lxde-common lxde-icon-theme omxplayer gcc-4.4-base:armhf gcc-4.5-base:armhf gcc-4.6-base:armhf libraspberrypi-doc xkb-data manpages
}

# function removeDeveloperPackages() {
#   echo ""
#   echo "## Removing developer packages..."
#   
#   sudo apt-get -y remove `sudo dpkg --get-selections | grep "\-dev" | sed s/install//`
# }

function zeroOutSwapFile() {
  echo ""
  echo "## Zero-out swap file..."
  echo ""
    
  # a swapfile is not a swap partition, so no using swapon|off from here on, use  dphys-swapfile swap[on|off]  for that
  #disapble swapping and fill swap with zeros
  #$SWAPOFF -a
  sudo dphys-swapfile swapoff
  sudo dd if=/dev/zero of=/var/swap bs=1M count=100
}

#################
# Cleanup steps #
#################

echo "###############################"
echo "Running disk-cleaning script..."
echo "###############################"

removePythonGames
removeUnnecessaryPackages
removeDeveloperPackages
zeroOutSwapFile
