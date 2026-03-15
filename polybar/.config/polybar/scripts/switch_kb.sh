#!/usr/bin/env bash

# Layouts to cycle through
LAYOUTS=("us" "lv")

current=$(setxkbmap -query | awk '/layout/ {print $2}')

idx=-1
for i in "${!LAYOUTS[@]}"; do
  if [ "${LAYOUTS[$i]}" = "$current" ]; then
    idx=$i
    break
  fi
done

if [ "$idx" -lt 0 ]; then
  next="${LAYOUTS[0]}"
else
  next_index=$(( (idx + 1) % ${#LAYOUTS[@]} ))
  next="${LAYOUTS[$next_index]}"
fi

setxkbmap "$next"
