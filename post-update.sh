# Install RetroArch binaries

sudo apt-get update; sudo apt-get install libretro-fceu retroarch retroarch-phoenix

# Create config file for running RetroArch

mkdir -p ~/.config/retroarch/
cp retroarch.cfg ~/.config/retroarch/

echo ""
echo "Now run it!:"
echo "retroarch <filename.nes> -c ~/.config/retroarch/retroarch.cfg -v"