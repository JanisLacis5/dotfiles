#!/usr/bin/env bash

CONFIG=/home/janis/.config
DOTFILES=/home/janis/dotfiles

cp -r "$CONFIG/i3" "$DOTFILES/"
cp -r "$CONFIG/kitty" "$DOTFILES/"
cp -r "$CONFIG/polybar" "$DOTFILES/"
cp -r "$CONFIG/rofi" "$DOTFILES/"

