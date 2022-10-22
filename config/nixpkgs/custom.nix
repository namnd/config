{ config, pkgs, ... }:

let unstable = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) { };
in
{
  # Your custom configuration
  home.packages = with pkgs; [
    # Neovim
    unstable.neovim
    trash-cli
    cht-sh

    delve
    gopls
    rnix-lsp
    sumneko-lua-language-server
    zls

    bat
    difftastic
    fd
    fzf
    tldr
    tree
  ];
}
