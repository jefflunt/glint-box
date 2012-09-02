# Download the `rpi-update` script and update the root ca-certificates

sudo wget http://goo.gl/1BOfJ -O /usr/bin/rpi-update && chmod +x /usr/bin/rpi-update
sudo apt-get install ca-certificates

# From http://superpiadventures.com/2012/08/retroarch-packages-for-raspbian/#comment-48

sudo echo "deb http://archive.changeover.za.net/raspbian wheezy main" > /etc/apt/sources.list.d/changeover.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
sudo apt-get update; sudo apt-get dist-upgrade
sudo rpi-update