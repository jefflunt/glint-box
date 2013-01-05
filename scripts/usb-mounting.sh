#!/usr/bin/env bash

#install autofs and udev
sudo apt-get -y install autofs udev

#create the mount point
sudo mkdir -p /mnt/usbdisk

#create a new udev rules file and add line
sudo echo -n 'ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd?[1-9]", SYMLINK+="usbdisk%n", RUN+="/usr/local/bin/copyroms.sh"' > /etc/udev/rules.d/80-usbdisk.rules

#restart udev
sudo /etc/init.d/udev restart

#add line to autofs file auto.master
sudo echo "/mnt /etc/auto.ext-usb --timeout=10,defaults,user,exec,uid=1000" >> /etc/auto.master

#create file and add line
sudo echo -n "usbdisk -fstype=auto :/dev/usbdisk1" > /etc/auto.ext-usb

#restart autofs
sudo /etc/init.d/autofs restart