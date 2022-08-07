#!/bin/sh

apps=(
  "gitconfig"
  "gitignore"
  "zshrc"
)
config=(
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

for app in ${apps[*]}
do
  ln -sfn $PWD/${app} $HOME/.${app}
done

for c in ${config[*]}
do
  ln -sfn $PWD/config/${c} $HOME/.config/${c}
done

# Install nvim plugin manager
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
