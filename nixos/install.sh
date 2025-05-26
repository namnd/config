#!/bin/sh

##########################################################
# Bootstrapping NixOS
##########################################################

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s "$PWD"/configuration.nix /etc/nixos/configuration.nix

nixos-rebuild switch

##########################################################
# Install home-manager
##########################################################

mkdir -p "$HOME"/.config
ln -sfn "$(readlink -f "$PWD"/../home-manager)" "$HOME"/.config/home-manager

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch

#################################################
# Fonts
#################################################

mkdir -p "$HOME"/.local/share
ln -sfn "$PWD"/fonts "$HOME"/.local/share/fonts
sudo fc-cache

#################################################
# Others
#################################################

ln -sfn "$(readlink -f "$PWD"/../nixpkgs)" "$HOME"/.config/nixpkgs
ln -sfn "$(readlink -f "$PWD"/../nvim)" "$HOME"/.config/nvim
ln -sfn "$(readlink -f "$PWD"/../ghostty)" "$HOME"/.config/ghostty
