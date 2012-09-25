# Update the root ca-certificates
sudo apt-get -y install ca-certificates

# Download retroarch binaries - from http://superpiadventures.com/2012/08/retroarch-packages-for-raspbian/#comment-48
echo "deb http://archive.changeover.za.net/raspbian wheezy main" | sudo tee /etc/apt/sources.list.d/changeover.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2747C7CF
sudo apt-get -y update; sudo apt-get -y dist-upgrade
