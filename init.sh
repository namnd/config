#!/bin/sh

apps=(
  "gitconfig"
  "gitignore"
  "hammerspoon"
  "qutebrowser"
)
config=(
  "karabiner"
  "kitty"
  "nvim"
)

for app in ${apps[*]}
do
  rm -rf $HOME/.${app}
  ln -sfn $PWD/${app} $HOME/.${app}
done

mkdir -p $HOME/.config
for c in ${config[*]}
do
  rm -rf $HOME/.config/${c}
  ln -sfn $PWD/config/${c} $HOME/.config/${c}
done

# nvim plugin manager
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# zsh configuration
touch $HOME/.zshrc
if ( ! $(cat $HOME/.zshrc | grep "$PWD/zshrc" > /dev/null) ); then
  echo "# Personal\nsource $PWD/zshrc" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
fi
