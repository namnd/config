#!/bin/sh

if [ ! -f "$PWD/custom.nix" ]; then
  echo '{ config, ... } : {}'  > $PWD/custom.nix
fi

if [ ! -x "$(command -v nix)" ]; then
  sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.18.0/install)" --daemon
  exit
fi

if [ ! -x "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi

home-manager switch
