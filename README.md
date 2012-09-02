## Goals and Philosophy

It's my desire to build a project that allows you to convert your Raspberry Pi into a great little emulation box. I'm most interested in NES emulation myself, but I'm open to discussing other systems supported by RetroArch (and others, if you're running your own projects).

My vision is to provide "turn on and play" functionality. That is, eventually you should be able to download a pre-built OS image to your SD card with everything installed and configured already, and all you have to do it plug the Raspberry Pi into your TV with a compatible controller and you're playing classic NES games in 30 seconds or less.

I'm going to try a lot of little experiments throughout the life of the project, tweaking the emulator settings, the RAM settings, swapping out various drivers and trying various distros to see what works best. While I'm open to learning about and understanding all the different ways the community might want to setup an emulation box, I'm most interested in the "turn on and play" potential that the Raspberry Pi offers, should it be plugged into your living room television.

The great thing about this is that a custom software stack for emulation is only a custom SD card away - your Raspberry Pi can literally be as many different things to you as the number of SD cards you have laying around.

## Prerequisites

1. Raspberry Pi Rev B. board (the one with the ethernet jack)
2. Power supply for your Pi. It should be at least **5.0 volts, 1 amp (or 1000 milliamps)**. I use the outlet-to-USB adapter I got with the iPad - it's 2 amps - more than enough. I believe the power supply for the Google Nexus 7 tablet is also sufficiently powerful. Your typical cell phone wall outlet power supply might also be sufficient, but double check the power output printed on the power supply itself.
3. SD card imaged with the 2012-08-16-wheezy-raspbian image (or possibly newer than this - this is the default, fully supported distro)
4. An available SD card that's at least 4GiB in size

## Build

Starting with a freshly imaged Raspberry Pi SD card, when the Raspberry Pi first boots up and you see the config screen, and do the following:

* Go to the "memory_split" section and change the option to "192 128MiB for ARM, 64 MiB for VideoCore"
* Go to the "expand_rootfs" section and expand the root partition to fill your SD card. The standard 1.7GiB doesn't seem to be enough out of the box for `git` and all the other dependencies. I've run into problems during the very last steps where the last binary or two ran out of space, just before I was about to start up RetroArch. What a tease!
* Changing the root filesystem (FS) size requires a reboot. When it prompts you to reboot, do it.

First, edit your `~/.profile` file, adding the following line the end (so RetroArch can find some needed libraries)

    export LD_LIBRARY_PATH=/opt/vc/lib

Then, clone this project somewhere (your home directory is a good option) and run the `pre-update.sh` script

    cd ~
    git clone git://github.com/normalocity/retroarch-nes-raspi-build.git
    cd retroarch-nes-raspi-build
    ./pre-update.sh

This will run some updates. It may take a long time (30 minutes?), and maybe longer if your on a DSL or slower connection. Be patient. :)

When it's done you'll **either** (a) be asked to reboot or (b) see a message on the last line that says something to the effect of "Your firmware is already up to date". Whatever it says, just reboot anyway.

After that's done, run the `post-update.sh` script, which will install some emulation software binaries and copy the RetroArch config file to your home directory with options that have been found to work *reasonably* well for the Raspberry Pi:

    cd ~/retroarch-nes-raspi-build
    ./post-update.sh
    
When that's done, you should see a message on your screen explaining how to launch RetroArch.

## Play!

...and please report issues that you run into. :)

**Controls:**

* Arrow keys to go up/down/left/right
* Start: Enter key
* Select: Right-shift key
* A button: X
* B button: Z

## Options

* Overclocking: I haven't done much with overclocking yet. I'd prefer not to overvolt as well, as I don't want anyone voiding their warranty in order to try this out. However, the project gets to the point where we're 99% of the way there, and just a slight overclock will get us the remaining 1% of performance that we need to get a near-perfect emulation experience, I'm up for trying it.

## Contact

Email me at jefflunt@gmail.com with your tests, tweaks, and experiences using this and RetroArch in general on Raspberry Pi. I'd love to collaborate and try things out to see if we can get "The Little Raspberry That Could" to deliver an awesome NES gaming experience.

## Current known issues

* Config options: You can, of course, tweak the config options anyway you like and report your results back to me. This repo provides (and automatically copies) a provided config file for you that should get you basically up and running, even if it's not a perfect experience.
* Sound: Audio in games currently ranges from "pretty close but not perfect" to "basically unplayable" - it's pretty bad. If the audio is killing you and you would rather just do without it, you can disable audio altogether by editing the `~/.config/retroarch/retroarch.cfg` file and change the line `audio_enable = "true"` to `audio_enbale = "false"`
* Controls: There are no controller drivers installed to get you going. RetroArch includes a utility called `retroarch-joyconfig` that you can use if you have a gamepad/arcade stick lying around with a USB plug on it. I can't promise that any particular controller will work, but you can try it out.
* Some games just flat out don't work. This seems to be at least somewhat related to the memory usage, what you set the `memory_split` to, and how that affects performance and/or whether certain games will even start up and work. I'm looking into options for this, including distros that are leaner and use less memory to begin with, which might help. No promises right now.