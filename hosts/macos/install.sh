#!/bin/sh

#################################################
# Install Nix
#################################################
if [ ! -x "$(command -v nix)" ]; then
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
  exit
fi

root_dir=$(readlink -f "$PWD"/../..)

##########################################################
# Install home-manager
##########################################################

mkdir -p "$HOME"/.config
ln -sfn "$root_dir"/home-manager "$HOME"/.config/home-manager

ln -sf "$root_dir"/home-manager/custom.macos.nix "$root_dir"/home-manager/custom.nix

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
