#!/bin/bash

export HOME="/home/pi"

SOURCE="/mnt/usbdisk"
TARGET="/home/pi/roms"

if [ -d "$TARGET" ]; then
   rm -rf $TARGET/*
fi
if [ -d "$SOURCE" ]; then
  # Stop glint-es, clear console, and start ROM file copy
  echo "Copying ROMs from USB stick...please wait..."
  find $SOURCE -type f \( -name "*.nes" -o -name "*.NES" -o -name "*.Nes" \) -a \( ! -regex '.*/\..*' \) -exec cp {} $TARGET \; 
  sudo chown -R pi:pi $HOME/roms
  
  # Unmount USB stick and restart glint-es
  sudo umount /mnt/removeable
  echo "Starting glint-es"
  killall glint-es && /home/pi/glint-es/glint-es &
else
   echo "ERR: $SOURCE does not exist."   
   exit 1
fi

exit 0