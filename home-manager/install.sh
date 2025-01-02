#!/bin/sh

set -xeu

mkdir -p "$HOME/.config"

ln -sfn "${PWD}" "${HOME}/.config/home-manager"

if [ ! -f "$HOME/.config/nixpkgs/config.nix" ]; then
  mkdir -p "$HOME/.config/nixpkgs"
  echo '{ allowUnfree = true; }'  > "$HOME/.config/nixpkgs/config.nix"
fi

if [ ! -x "$(command -v nix)" ]; then
  sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.25.3/install)" --daemon
  exit
fi

if [ ! -x "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
  nix-channel --update
  export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
  nix-shell '<home-manager>' -A install
fi

home-manager switch
