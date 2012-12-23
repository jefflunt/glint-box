export PIHOME="/home/pi"

# Set the glint-nes branch to pull from on github if it isn't already set
  if [ -z "$GLINTNESBRANCH" ]
  then
    export GLINTNESBRANCH=master
  fi
}

# Pull down component scripts
curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/scripts/clean-pi.sh > $PIHOME/clean-pi.sh
curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/config/scripts/glint-nes.sh > $PIHOME/glint-nes.sh

# Run scripts
. clean-pi.sh
. glint-nes.sh

# Finish
echo "\n\nRebooting...\n"
shutdown -r now