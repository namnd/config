{ config, pkgs, ... }:

{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
             url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
             }))
  ];

  home.packages = with pkgs; [
    direnv
    fzf
    jq
    gh
    go
    gopls
    gvproxy
    kitty
    neovim-nightly
    rnix-lsp
    nodejs
    ripgrep
    tmux
    trash-cli
    tree-sitter
  ];

  programs.home-manager.enable = true;
}
