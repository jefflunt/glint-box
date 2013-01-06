#!/bin/bash

export HOME="/home/pi"

SOURCE="/mnt/usbdisk"
TARGET="/home/pi/roms"

if [ -d "$TARGET" ]; then
   rm -rf $TARGET/*
fi
if [ -d "$SOURCE" ]; then
   find $SOURCE -type f \( -name "*.nes" -o -name "*.NES" -o -name "*.Nes" \) -a \( ! -regex '.*/\..*' \) -exec cp {} $TARGET \; 
   echo "Copied ROMs to $TARGET" >> /var/log/syslog
   sudo chown -R pi:pi $HOME/roms
   killall glint-es && /home/pi/glint-es/glint-es &
   sudo umount /mnt/removeable
else
   echo "ERR: $SOURCE does not exist."   
   exit 1
fi

exit 0