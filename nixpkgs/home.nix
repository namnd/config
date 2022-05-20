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
    csvkit
    direnv
    emacs
    fd
    fzf
    jq
    gh
    unstable.go_1_18
    gopls
    gvproxy
    unstable.neovim
    rnix-lsp
    nmap
    nodejs
    pgcli
    ripgrep
    tmux
    trash-cli
    tree-sitter
  ];

  programs.home-manager.enable = true;
}
