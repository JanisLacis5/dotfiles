#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log
# polybar example 2>&1 | tee -a /tmp/polybar1.log & disown

# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar --reload example &
#   done
# else
#   polybar --reload example &
# fi

if type "xrandr" >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR="$m" polybar --reload example 2>&1 | tee -a "/tmp/polybar-$m.log" & disown
  done
else
  polybar --reload example 2>&1 | tee -a /tmp/polybar.log & disown
fi

echo "Bars launched..."
