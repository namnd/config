#!/bin/sh

if [ "$1" ]; then
  sed -i "s/git_email/$1/g" $HOME/dotfiles/config/nixpkgs/custom.nix
fi

sed -i "s/https:\/\/github.com\/namnd\/dotfiles.git/git@github.com:namnd\/dotfiles.git/g" $HOME/dotfiles/.git/config

# install Home manager if not yet installed
if [ ! -x "$(command -v home-manager)" ]; then
  mkdir -p /nix/var/nix/profiles/per-user/root/channels
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  nix-shell '<home-manager>' -A install
fi

mkdir -p $HOME/.config

ln -sfn $PWD/config/nixpkgs $HOME/.config/nixpkgs
ln -sfn $PWD/config/nvim $HOME/.config/nvim

home-manager switch
