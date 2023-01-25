#!/bin/sh

mkdir -p $HOME/.config

ln -sfn "${PWD}/hammerspoon" "${HOME}/.hammerspoon"
ln -sfn "${PWD}/qutebrowser" "${HOME}/.qutebrowser"
ln -sfn "${PWD}/kitty" "${HOME}/.config/kitty"
ln -sfn "${PWD}/nixpkgs" "${HOME}/.config/nixpkgs"

# Install nix
sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.8.1/install)" --daemon

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install

home-manager switch
