#!/bin/bash

STEP=0.1
MIN=0.10
MAX=1.0

# Get current brightness
current=$(xrandr --verbose | grep -i brightness | head -n1 | cut -d ' ' -f2)

# Calculate new brightness
if [ "$1" = "up" ]; then
  new=$(echo "$current + $STEP" | bc)
elif [ "$1" = "down" ]; then
  new=$(echo "$current - $STEP" | bc)
else
  echo "Usage: $0 {up|down}"
  exit 1
fi

# Clamp brightness between MIN and MAX
new=$(echo "$new" | awk -v min=$MIN -v max=$MAX '{ if ($1 < min) print min; else if ($1 > max) print max; else print $1 }')

# Apply new brightness
xrandr --output "$(xrandr | grep ' connected' | cut -d ' ' -f1)" --brightness "$new"

