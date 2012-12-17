![glint - retro emulation for the masses](https://s3-us-west-2.amazonaws.com/glint-images/glint.png "glint - retro emulation for the masses")

## Help, news, and contact info

I've setup two Google groups to help users.

* [glint help](https://groups.google.com/forum/?hl=en&fromgroups=#!forum/glint-help) - Q&A for glint box builders and modders
* [glint news](https://groups.google.com/forum/?hl=en&fromgroups=#!forum/glint-news) - low traffic, official announcements of glint releases and updates

You can also reach me at <jefflunt@gmail.com> if you like, but if you're looking for support with building or modding a glint box (as opposed to a GitHub coding issue), please forward your question to the glint help group referenced above.

## Goals and Philosophy

It's my desire to build a project that allows you to convert your Raspberry Pi into a great little emulation box. To get started I'm working on glint-nes, the first of many dedicated, single-console emulation boxes.

My vision is to provide "turn on and play" functionality. That is, eventually you should be able to download a [pre-built OS image](http://karmanebula.com/glint-downloads/) to your SD card with everything installed and configured already, and all you have to do is plug the Raspberry Pi into your TV with a compatible controller and you're playing classic NES games in 30 seconds or less (BYOR - bring your own ROMs).

### The glint-nes team

I wanted to publicly recognize a few people who have contributed to the project or supported it with information and testing:

* [Brandt Daniels](http://pomprocker.blogspot.com/) - Linux systems expert - has contributed some automation and scripting help, along with guidance on how to better integrate the project with the OS
* [Alec "Aloshi" Lofquist](http://www.aloshi.com/) - Author of EmulationStation - **glint-nes** utilizes a customized version of [EmulationStation](https://github.com/Aloshi/EmulationStation), called **[glint-es](https://github.com/normalocity/glint-es)**, and Aloshi has been incredibly supportive and helpful in my programming efforts to customize it to glint-nes' needs
* [@50437 on twitter](https://twitter.com/50437) - tester - has tested and provided feedback on the **glint-nes** project
* [Jeff Lunt](http://jefflunt.com) - and I am your humble project organizer, primarily doing programming tasks and tweaking to get everything working together

**I'd also like to thank** many testers and supporters of the project who have elected to remain anonymous. Your feedback and support have been greatly appreciated!

## How to get a working glint-nes box

**These paths are mutually exclusive** (i.e. pick only one, don't try to do both - they will conflict)

* [Download a pre-build OS image](http://karmanebula.com/glint-downloads/), flash your SD card, and boot up your Pi. This is the least complicated approach and should give you a known working experience
* Follow the prerequisites and build instructions below

## Prerequisites

1. Raspberry Pi Rev B. board (the one with the ethernet jack). Either the 256MB or 512MB models work just fine.
2. Power supply for your Pi. It should be at least **5.0 volts, 1 amp (or 1000 milliamps)**. I use the outlet-to-USB adapter I got with the iPad - it's 3 amps - more than enough. I believe the power supply for the Google Nexus 7 tablet is also sufficiently powerful. Your typical cell phone wall outlet power supply might also be sufficient, but double check the power output printed on the power supply itself.
4. 4GB SD card (minimum size) imaged with the [Raspbian Wheezy minimal image](https://s3-us-west-2.amazonaws.com/glint-images/raspbian_wheezy_20120608.img.7z).

## Build

After imaging your SD card, boot up your Raspberry Pi, login, and then:

* At the console, type: `curl -L https://raw.github.com/normalocity/glint-nes/master/install.sh | bash`

This command runs a script from the project that downloads and installs everything you need, including config files and settings for the Raspberry Pi.

## Play! (BYOR - Bring Your Own ROMs)

Place any ROMs you have under the `/root/roms` folder and reboot the RPi. This time it should boot straight into the graphical frontend

Please [report issues](https://groups.google.com/forum/?hl=en&fromgroups=#!forum/glint-help) that you run into. :)

**But where are the game ROMs?**

You'll have to find those on your own. Please don't email me asking for ROMs.

**Controls:**

[This awesome controller I got from Amazon](http://www.amazon.com/gp/product/B00281PFQI) is the one I'm using now - it's a great replica retro USB controller.

## Current known issues

* **Config options**: You can, of course, tweak the config options anyway you like and report your results back to me. This repo provides (and automatically copies) a provided config file for you that should get you basically up and running, even if it's not a perfect experience.
* **Sound/Speed**: Sound and emulation speed is still glitchy in some games, but we have a long list of games known to work well the the latest build. You can see the list [here.](http://karmanebula.com/game-support/)
* **Some games just flat out don't work**. A few of the most popular games (e.g. "Mike Tyson's Punchout") just work like crap. This game in particular seems to be especially troublesome on the Raspberry Pi's limited hardware. The reasons (as it's been explained to me) is that some elements of the NES hardware, while emulated, are extremely inefficient to emulate in software, and as such some games just won't work, or won't work very well. We're looking for tweaks and config changes to the emulator that we might be able to do that can lessen or eliminate this proble, but there are still issues. Again, if a specific game is incredibly important to you, please check [the supported games](http://karmanebula.com/game-support/) list to look for known issues.