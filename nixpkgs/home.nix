{ config, pkgs, ... }:

let 
  unstable = import <nixpkgs-unstable> {};
in
{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    black
    direnv
    fzf
    jq
    gh
    go
    gopls
    gvproxy
    kitty
    neovim
    rnix-lsp
    nmap
    nodejs
    ripgrep
    unstable.tailscale
    tmux
    trash-cli
    tree-sitter
  ];

  programs.home-manager.enable = true;
}
