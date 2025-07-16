current_volume=$(pactl get-sink-volume 0 | awk -F'/' '/Volume:/ { gsub(/%/, "", $2); print $2 }' | head -n1)

if [ $1 == "down" ]; then
    pactl set-sink-volume 0 -5%
    exit 0
fi

if [ $1 == "up" ] && [ "${current_volume}" -lt 125 ]; then
    pactl set-sink-volume 0 +5%
fi
