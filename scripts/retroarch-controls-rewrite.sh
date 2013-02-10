#!/bin/bash

# USAGE: Pass a player index (0 or 1), a controller number, and the button assignments
# to this script in the following order:
# PI CI up down left right a b select start
PLAYER=$1
CONTROLLER=$2
RACONFIG="/home/pi/.retroarch/retroarch.cfg"

declare -A buttons

buttons=( ["up"]="$3" ["down"]="$4" ["left"]="$5" ["right"]="$6" ["b"]="$7" ["a"]="$8" ["select"]="$9" ["start"]="$10" )

sed -ie "s/input_player$PLAYER_joypad_index.*/input_player$PLAYER_joypad_index = \"$PLAYER\"/g" $RACONFIG

sed -ie "s/input_player$PLAYER_up_axis.*/input_player$PLAYER_up_axis = \"-${buttons["up"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_down_axis.*/input_player$PLAYER_down_axis = \"+${buttons["down"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_left_axis.*/input_player$PLAYER_left_axis = \"-${buttons["left"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_right_axis.*/input_player$PLAYER_right_axis = \"+${buttons["right"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_b_btn.*/input_player$PLAYER_b_btn = \"${buttons["b"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_a_btn.*/input_player$PLAYER_a_btn = \"${buttons["a"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_select_btn.*/input_player$PLAYER_select_btn = \"${buttons["select"]}\"/g" $RACONFIG
sed -ie "s/input_player$PLAYER_start_btn.*/input_player$PLAYER_start_btn = \"${buttons["start"]}\"/g" $RACONFIG
