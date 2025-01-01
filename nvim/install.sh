#!/bin/sh

set -xeu

mkdir -p "$HOME/.config"

ln -sfn "${PWD}" "${HOME}/.config/nvim"

