#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
CONFIG_DIR="$HOME/.config"

# Patches
ALACRITTY_LAST_WD=("alacritty_open_last_wd" "./last_wd.sh")

apply_patch() {
  local patch_id_file_arr="$1"
  if grep -q ${patch_id_file_arr[0]} ~/.bashrc; then
    echo "patch ${patch_id_file_arr[0]} already installed"
  else
    echo "$(cat ${patch_id_file_arr[1]})" >>~/.bashrc
  fi
}

apply_patch $ALACRITTY_LAST_WD
pushd ${CONFIG_DIR} >/dev/null
mkdir -p bspwm sxhkd polybar picom dunst
popd >/dev/null

function cp_and_add_x() {
  cp $1 $2
  chmod +x $2
}

cp_and_add_x ${SCRIPT_DIR}/bspwm.config ${CONFIG_DIR}/bspwm/bspwmrc
cp_and_add_x ${SCRIPT_DIR}/sxhkd.config ${CONFIG_DIR}/sxhkd/sxhkdrc
cp_and_add_x ${SCRIPT_DIR}/picom.config ${CONFIG_DIR}/picom/picom.conf
cp_and_add_x ${SCRIPT_DIR}/polybar.config ${CONFIG_DIR}/polybar/config.ini
cp_and_add_x ${SCRIPT_DIR}/dunst.config ${CONFIG_DIR}/dunst/dunstrc
cp_and_add_x ${SCRIPT_DIR}/audio.sh ${CONFIG_DIR}/sxhkd/audio.sh
cp_and_add_x ${SCRIPT_DIR}/brightness.sh ${CONFIG_DIR}/sxhkd/brightness.sh
cp_and_add_x ${SCRIPT_DIR}/kbd_backlight.sh ${CONFIG_DIR}/sxhkd/kbd_backlight.sh

# Make keyboard brightness file writable, this will need to be done but i dont want to do it here
# chmod ugo+w /sys/class/leds/*kbd_backlight/brightness
