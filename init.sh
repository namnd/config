#!/bin/sh

apps=(
  "gitconfig"
  "gitignore"
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
    "kitty"
  )
fi

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

# zsh configuration
touch $HOME/.zshrc
if ( ! $(cat $HOME/.zshrc | grep "$PWD/zshrc" > /dev/null) ); then
  echo "source $PWD/zshrc # Personal" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
fi
