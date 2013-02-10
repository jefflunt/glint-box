#!/bin/bash

# USAGE: Pass a player index (0 or 1), a controller number, and the button assignments
# to this script in the following order:
# PI CI up down left right a b select start
PLAYER=expr $1 #zero-indexed
CONTROLLER=$2
RACONFIG="/home/pi/.retroarch/retroarch.cfg"

declare -A buttons

buttons=( ["up"]="$3" ["down"]="$4" ["left"]="$5" ["right"]="$6" ["b"]="$7" ["a"]="$8" ["select"]="$9" ["start"]="$10" )

sed -ie "s/input_player${PLAYER}_joypad_index.*/input_player${PLAYER}_joypad_index = \"${PLAYERINDEX}\"/g" $RACONFIG

sed -ie "s/input_player${PLAYER}_up_axis.*/input_player${PLAYER}_up_axis = \"-${buttons["up"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_down_axis.*/input_player${PLAYER}_down_axis = \"+${buttons["down"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_left_axis.*/input_player${PLAYER}_left_axis = \"-${buttons["left"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_right_axis.*/input_player${PLAYER}_right_axis = \"+${buttons["right"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_b_btn.*/input_player${PLAYER}_b_btn = \"${buttons["b"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_a_btn.*/input_player${PLAYER}_a_btn = \"${buttons["a"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_select_btn.*/input_player${PLAYER}_select_btn = \"${buttons["select"]}\"/g" $RACONFIG
sed -ie "s/input_player${PLAYER}_start_btn.*/input_player${PLAYER}_start_btn = \"${buttons["start"]}\"/g" $RACONFIG
