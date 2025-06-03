#!/bin/sh

##########################################################
# Bootstrapping NixOS
##########################################################

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s "$PWD"/configuration.nix /etc/nixos/configuration.nix

sudo mkdir -p /var/local/dwmblocks
sudo chmod 777 /var/local/dwmblocks

sudo nixos-rebuild switch

root_dir=$(readlink -f "$PWD"/../..)

##########################################################
# Install home-manager
##########################################################

mkdir -p "$HOME"/.config
ln -sfn "$root_dir"/home-manager "$HOME"/.config/home-manager

cp "$root_dir"/home-manager/custom.nixos.nix "$root_dir"/home-manager/custom.nix

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch

#################################################
# Fonts
#################################################

mkdir -p "$HOME"/.local/share
ln -sfn "$root_dir"/fonts "$HOME"/.local/share/fonts
sudo fc-cache

#################################################
# Others
#################################################

ln -sfn "$root_dir"/nvim "$HOME"/.config/nvim
ln -sfn "$root_dir"/ghostty "$HOME"/.config/ghostty
