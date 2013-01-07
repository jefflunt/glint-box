#!/bin/bash

export HOME="/home/pi"

SOURCE="/mnt/usbdisk"
TARGET="/home/pi/roms"

if [ -d "$TARGET" ]; then
   rm -rf $TARGET/*
fi
if [ -d "$SOURCE" ]; then
  # Stop glint-es, clear console, and start ROM file copy
  find $SOURCE -type f \( -name "*.nes" -o -name "*.NES" -o -name "*.Nes" \) -a \( ! -regex '.*/\..*' \) -exec cp {} $TARGET \; 
  sudo chown -R pi:pi $HOME/roms
  echo "Copied ROMs to $TARGET" >> /var/log/syslog
  
  # Unmount USB stick and restart glint-es
  sudo umount $SOURCE
  killall glint-es && /home/pi/glint-es/glint-es &
else
   echo "ERR: $SOURCE does not exist."   
   exit 1
fi

exit 0