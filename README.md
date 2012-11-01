![glint - retro emulation for the masses](http://karmanebula.squarespace.com/storage/design/glint.png "glint - retro emulation for the masses")

## Help, news, and contact info

I've setup two Google groups to help users.

* [glint help](https://groups.google.com/forum/?hl=en&fromgroups=#!forum/glint-help) - Q&A for glint box builders and modders
* [glint news](https://groups.google.com/forum/?hl=en&fromgroups=#!forum/glint-news) - low traffic, official announcements of glint releases and updates

You can also reach me at <jefflunt@gmail.com> if you like, but if you're looking for support with building or modding a glint box (as opposed to a GitHub coding issue), please forward your question to the glint help group referenced above.

## Goals and Philosophy

It's my desire to build a project that allows you to convert your Raspberry Pi into a great little emulation box. I'm most interested in NES emulation myself, but I'm open to discussing other systems supported by RetroArch (and others, if you're running your own projects).

My vision is to provide "turn on and play" functionality. That is, eventually you should be able to download a pre-built OS image to your SD card with everything installed and configured already, and all you have to do is plug the Raspberry Pi into your TV with a compatible controller and you're playing classic NES games in 30 seconds or less.

I'm going to try a lot of little experiments throughout the life of the project, tweaking the emulator settings, the RAM settings, swapping out various drivers and trying various distros to see what works best. While I'm open to learning about and understanding all the different ways the community might want to setup an emulation box, I'm most interested in the "turn on and play" potential that the Raspberry Pi offers, should it be plugged into your living room television.

The great thing about this is that a custom software stack for emulation is only a custom SD card away - your Raspberry Pi can literally be as many different things to you as the number of SD cards you have laying around.

## Prerequisites

1. Raspberry Pi Rev B. board (the one with the ethernet jack)
2. Power supply for your Pi. It should be at least **5.0 volts, 1 amp (or 1000 milliamps)**. I use the outlet-to-USB adapter I got with the iPad - it's 2 amps - more than enough. I believe the power supply for the Google Nexus 7 tablet is also sufficiently powerful. Your typical cell phone wall outlet power supply might also be sufficient, but double check the power output printed on the power supply itself.
3. SD card (4 GiB minimum size) imaged with the **2012-09-18-wheezy-raspbian** image

## Build

Start with a freshly imaged Raspberry Pi SD card. When the Raspberry Pi first boots up you will see the config screen. Change the following options:

* Go to the "memory_split" section and change the option to "192 128MiB for ARM, 64 MiB for VideoCore"
* Go to the "expand_rootfs" section and expand the root partition to fill your SD card. The standard 1.7GiB doesn't seem to be enough out of the box for `git` and all the other dependencies. I've run into problems during the very last steps where the last binary or two ran out of space, just before I was about to start up RetroArch. What a tease!
* Go to the "overclock" option, skip past the warning, and set your Raspberry Pi to "Modest 800MHz ARM, 300MHz core, 400MHz SDRAM, 0 overvolt"
* Changing the root filesystem (FS) size requires a reboot. When it prompts you to reboot, do it.

First, edit your `~/.profile` file, adding the following line the end (so RetroArch can find some needed libraries)

    export LD_LIBRARY_PATH=/opt/vc/lib

Then, clone this project somewhere (your home directory is a good option) and run the `pre-update.sh` script

    cd ~
    git clone https://github.com/normalocity/glint-nes.git
    cd glint-nes
    ./all-in-one.sh

This will run some updates. It may take a long time (30 minutes?), and maybe longer if you're on a DSL or slower connection. Be patient. :)

When it's done, the system should prompt you to reboot, as well as give you instructions on how to start retroarch after your machine starts up and you log in again. Just for reference you run retroarch using the following command:

`retroarch <filename.nes> -c ~/.config/retroarch/retroarch.cfg`

## Play!

...and please report issues that you run into. :)

**But where are the game ROMs?**

You'll have to find those on your own. Please don't email me asking for ROMs.

**Controls:**

[This awesome controller I got from Amazon](http://www.amazon.com/gp/product/B00281PFQI) is the one I'm using now. If you configure your controller correctly the first time, then the retroarch config that I supply with this project should work out-of-the-box for you.

## Options

* Overclocking: I haven't done much with overclocking yet. I'd prefer not to overvolt as well, as I don't want anyone voiding their warranty in order to try this out. However, if the project gets to the point where we're 99% of the way there, and just a slight overclock will get us the remaining 1% of performance that we need to get a near-perfect emulation experience, I'm up for trying it.

## Current known issues

* **Config options**: You can, of course, tweak the config options anyway you like and report your results back to me. This repo provides (and automatically copies) a provided config file for you that should get you basically up and running, even if it's not a perfect experience.
* **Sound**: Audio in games currently ranges from "pretty close but not perfect" to "basically unplayable." I'll be honest, it's pretty bad. If the audio is killing you and you would rather just do without it, you can disable audio altogether by editing the `~/.config/retroarch/retroarch.cfg` file and change the line `audio_enable = "true"` to `audio_enbale = "false"`
* **Controls**: The default controller drivers should work fine, according to my testing. I specifically used [this awesome controller I got from Amazon](http://www.amazon.com/gp/product/B00281PFQI) which is an exact replica (look and feel) of the original NES controller. The default config file is built to use this controller. If you buy and use this controller you will have **close** to a "sit down and play" experience.
* **Some games just flat out don't work**. This seems to be at least somewhat related to the memory usage, what you set the `memory_split` to, and how that affects performance and/or whether certain games will even start up and work. I'm looking into options for this, including distros that are leaner and use less memory to begin with, which might help. No promises on this front right now.