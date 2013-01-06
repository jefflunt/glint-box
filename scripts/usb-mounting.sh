#!/usr/bin/env bash

#install autofs and udev
sudo apt-get -y install autofs udev

#create the mount point
sudo mkdir -p /mnt/usbdisk

#create a new udev rules file and add line
echo -n 'ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd?[1-9]", SYMLINK+="usbdisk%n", RUN+="/usr/local/bin/copy-roms.sh"' > $HOME/80-usbdisk.rules
sudo mv $HOME/80-usbdisk.rules /etc/udev/rules.d/80-usbdisk.rules

#restart udev
sudo /etc/init.d/udev restart

#add line to autofs file auto.master
echo "/mnt /etc/auto.ext-usb --timeout=10,defaults,user,exec,uid=1000" >> $HOME/auto.master
sudo mv $HOME/auto.master /etc/auto.master

#create file and add line
echo -n "usbdisk -fstype=auto :/dev/usbdisk1" > $HOME/auto.ext-usb
sudo mv $HOME/auto.ext-usb /etc/auto.ext-usb

#restart autofs
sudo /etc/init.d/autofs restart