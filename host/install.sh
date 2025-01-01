#!/bin/sh

set -xeu

mkdir -p "$HOME/.config"

ln -sfn "${PWD}/hammerspoon" "${HOME}/.hammerspoon"
ln -sfn "${PWD}/ghostty" "${HOME}/.config/ghostty"
