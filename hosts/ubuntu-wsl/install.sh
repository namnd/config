#!/bin/sh

#################################################
# Install Nix
#################################################

#export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

#################################################
# Install home-manager
#################################################

#nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

ln -sf ~/config/home-manager/custom.ubuntu-wsl.nix ~/config/home-manager/custom.nix
ln -sfn ~/config/home-manager ~/.config/home-manager

