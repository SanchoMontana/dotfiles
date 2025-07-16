#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
CONFIG_DIR="$HOME/.config"

pushd ${CONFIG_DIR} > /dev/null
mkdir -p bspwm sxhkd polybar picom dunst
popd > /dev/null

function cp_and_add_x() {
    cp $1 $2;
    chmod +x $2;
}

cp_and_add_x ${SCRIPT_DIR}/wm_utils/bspwm.config ${CONFIG_DIR}/bspwm/bspwmrc 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/sxhkd.config ${CONFIG_DIR}/sxhkd/sxhkdrc 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/picom.config ${CONFIG_DIR}/picom/picom.conf 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/polybar.config ${CONFIG_DIR}/polybar/config.ini 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/dunst.config ${CONFIG_DIR}/dunst/dunstrc 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/audio.sh ${CONFIG_DIR}/sxhkd/audio.sh 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/brightness.sh ${CONFIG_DIR}/sxhkd/brightness.sh 
cp_and_add_x ${SCRIPT_DIR}/wm_utils/kbd_backlight.sh ${CONFIG_DIR}/sxhkd/kbd_backlight.sh 

# Make keyboard brightness file writable, this will need to be done but i dont want to do it here
# chmod ugo+w /sys/class/leds/*kbd_backlight/brightness
