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

  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
    signing = {
      key = "3E656F30";
      signByDefault = true;
    };
    aliases = {
      undo = "!git reset HEAD~1 --mixed";
      graph = "!f()  { git log --graph --abbrev-commit --decorate --all; }; f";
    };
    extraConfig = {
      color = {
        ui = true;
        diff = true;
        status = true;
        branch = true;
        interactive = true;
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      push.default = "current";
      format.pretty = "%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)";
    };
    ignores = [
      "Session.vim"
      "packer_compiled.lua"
      ".direnv"
    ];
  };

  imports = [
    ./custom.nix
  ];
}
