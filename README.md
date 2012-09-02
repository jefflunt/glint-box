## Prerequisites

1. Raspberry Pi Rev B. board
2. SD card imaged with the 2012-08-16-wheezy-raspbian image (or possibly newer than this)

## Build

Starting with a freshly imaged Raspberry Pi SD card, when the Raspberry Pi first boots up and you see the config screen, and do the following:

1. Go to the "memory_split" section and change the option to "128 128MiB for ARM, 128 MiB for VideoCore"
2. Go to the "expand_rootfs" section and expand the root partition to fill your SD card. The standard 1.7GiB doesn't seem to be enough out of the box for `git` and all the other dependencies. I've run into problems during the very last steps where the last binary or two ran out of space, like just before I was about to start up RetroArch.
3. Changing the root filesystem (FS) size requires a reboot. When it prompts you to reboot, do it.

Then, clone this project somewhere and run the `pre-update.sh` script

    cd ~
    git clone git://github.com/normalocity/retroarch-nes-raspi-build.git
    cd retroarch-nes-raspi-build
    ./pre-update.sh

This will run some updates. It may take a long time (30 minutes?) - be patient. When it's done you'll be asked to reboot. Do so.
    
After that's done, run the `post-update.sh` script:

    cd ~/retroarch-nes-raspi-build
    ./post-update.sh
    
When that's done, you should see a message on your screen explaining how to launch RetroArch.

## Play!

...and please report issues that you run into. :)