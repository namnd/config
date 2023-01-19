#!/bin/sh

if [ "$1" ]; then
  sed -i "s/userEmail/$1/g" $HOME/dotfiles/gitconfig
fi

apps=(
  "gitconfig"
  "gitignore"
)
config=(
  "nvim"
  "nixpkgs"
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

# install Nix (2.8.1) for multi user (for Mac only)
if [ ! -x "$(command -v nix)" ]; then
  sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.8.1/install)" --daemon
fi

# install Home manager if not yet installed
if [ ! -x "$(command -v home-manager)" ]; then
  mkdir -p /nix/var/nix/profiles/per-user/root/channels
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  nix-shell '<home-manager>' -A install
fi

home-manager switch
