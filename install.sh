#!/bin/sh

if [ ! -f "$PWD/custom.nix" ]; then
  echo '{ config, ... } : {}'  > $PWD/custom.nix
fi

if [ ! -x "$(command -v nix)" ]; then
  sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.22.1/install)" --daemon
  exit
fi

if [ ! -x "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  nix-shell '<home-manager>' -A install
fi

home-manager switch
