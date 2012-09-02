First, start with a freshly imaged Raspberry Pi OS image. I'm using the Debian (wheezy) for my builds.

When the Raspberry Pi first boots up and you see the config screen:

    Go to the "memory_split" section and change the option to "128 128MiB for ARM, 128 MiB for VideoCore"

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

Please report bugs. :)