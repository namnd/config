#!/bin/sh

##########################################################
# Bootstrapping NixOS
##########################################################

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s "$PWD"/configuration.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch

root_dir=$(readlink -f "$PWD"/../..)

##########################################################
# Install home-manager
##########################################################

mkdir -p "$HOME"/.config
ln -sfn "$root_dir"/home-manager "$HOME"/.config/home-manager

ln -sf "$root_dir"/home-manager/custom.nixos.nix "$root_dir"/home-manager/custom.nix

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch
