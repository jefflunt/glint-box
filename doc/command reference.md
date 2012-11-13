### To make a disk image of the first 2GB of `disk1` with 1MB blocks:

*Note: 1MB blocks * count of 1850 = 2GB of data*

    sudo dd bs=1m count=1850 if=/dev/disk1 of=~/path/to/output/file