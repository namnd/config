#!/bin/sh

files=(
  "config"
  "gitconfig"
  "gitignore"
  "hammerspoon"
  "qutebrowser"
  "zshrc"
)
for file in ${files[*]}
do
  ln -sf $PWD/$file $HOME/.${file}
done
