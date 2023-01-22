{ config, pkgs, lib, ... }:

let
  unstable = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) { };
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    awscli2
    aws-vault
    coreutils
    csvkit
    jq

    # Nix LSP
    rnix-lsp

    # Neovim related
    unstable.neovim
    cht-sh
    lemonade # remote clipboard over TCP

    # Other CLI tools
    fd
    fzf
    tldr
    tree
    pass
    cloc
    hugo
    ripgrep
    gcc
    unzip
  ];

  programs.direnv = {
    enable = true;
    config = {
      global = {
        warn_timeout = "10m";
      };
    };
    nix-direnv = {
      enable = true;
    };
  };

  imports = [
    ./custom.nix
  ];
}
