#!/bin/sh

##########################################################
# Update /etc/nixos/configuration.nix
##########################################################

CONFIG=/etc/nixos/configuration.nix
REMOTE_CONFIG=https://github.com/namnd/home/blob/main/nixos/configuration.nix

curl $REMOTE_CONFIG -o $CONFIG

nixos-rebuild switch

# Now that we have git
git clone https://github.com/namnd/dwm ~/dwm

##########################################################
# Install home-manager
##########################################################

HM_PATH=$HOME/.config/home-manager/
REMOTE_HM_CONFIG=https://github.com/namnd/home/blob/main/nixos/home.nix

mkdir -p "$HM_CONFIG"
curl $REMOTE_HM_CONFIG -o "$HM_PATH"/home.nix

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
nix-shell '<home-manager>' -A install

home-manager switch
