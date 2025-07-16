kbd_file="/sys/class/leds/asus::kbd_backlight/brightness"
current_backlight=$(cat ${kbd_file})
if [[ $1 == "down" && $current_backlight -gt 0 ]]; then
	echo $((current_backlight - 1)) > $kbd_file 
fi

if [[ $1 == "up" && $current_backlight -lt 3 ]]; then
	echo $((current_backlight + 1)) > $kbd_file 
fi

