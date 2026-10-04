#!/usr/bin/env bash

while true; do
  volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk '
    NR == 1 {
      for (i = 1; i <= NF; i++) {
        if ($i ~ /^[0-9]+%$/) {
          value = $i
          sub(/%$/, "", value)
          value += 0
          print value "%"
          exit
        }
      }
    }
  ')

  if [ -n "$volume" ]; then
    printf '  %s\n' "$volume"
  else
    printf '\n'
  fi

  sleep 0.2
done
