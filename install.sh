#!/bin/sh

if [ "$1" ]; then
  sed -i "s/git_email/$1/g" $HOME/.config/nixpkgs/custom.nix
fi

sed -i "s/https:\/\/github.com\/namnd\/nixpkgs/git@github.com:namnd\/nixpkgs.git/g" $HOME/.config/nixpkgs/.git/config

if [ ! -x "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  nix-shell '<home-manager>' -A install
fi

home-manager switch
