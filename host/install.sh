#!/bin/sh

mkdir -p $HOME/.config

ln -sfn "${PWD}/hammerspoon" "${HOME}/.hammerspoon"
ln -sfn "${PWD}/qutebrowser" "${HOME}/.qutebrowser"

mkdir -p $HOME/.config/kitty
ln -sf "${PWD}/kitty/tab_bar.py" "${HOME}/.config/kitty/"
