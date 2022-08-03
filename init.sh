#!/bin/sh

apps=(
  "aws"
  "gitconfig"
  "gitignore"
  "zshrc"
)
config=(
  "direnv"
  "nixpkgs"
  "nvim"
)

if [[ "$OSTYPE" == "darwin"* ]]; then
  apps+=(
    "hammerspoon"
    "qutebrowser"
  ) 
  config+=(
    "emacs"
    "karabiner"
    "kitty"
  )
fi

mkdir -p $HOME/.config

for file in ${files[*]}
do
  ln -sf $PWD/${file} $HOME/.${file}
done

for c in ${config[*]}
do
  ln -sf $PWD/config/${c} $HOME/.config/${c}
done

# Home-manager
if [ ! -x "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi

# Install nvim plugin manager
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
