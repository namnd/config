#!/bin/sh

##########################################################
# Bootstrapping NixOS
##########################################################

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s "$PWD"/configuration.nix /etc/nixos/configuration.nix

root_dir=$(readlink -f "$PWD"/../..)

##########################################################
# Install home-manager
##########################################################

mkdir -p "$HOME"/.config
ln -sfn "$root_dir"/home-manager "$HOME"/.config/home-manager

ln -sf "$root_dir"/home-manager/custom.nixos-wsl.nix "$root_dir"/home-manager/custom.nix

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch


#################################################
# Others
#################################################

ln -sfn "$root_dir"/nvim "$HOME"/.config/nvim
