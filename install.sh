#!/bin/sh

echo '{ config, ... } : {}'  > $PWD/custom.nix

if [ ! -x "$(command -v nix)" ]; then
  sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.16.1/install)" --daemon
  exit
fi

if [ ! -x "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  nix-shell '<home-manager>' -A install
fi

home-manager switch
