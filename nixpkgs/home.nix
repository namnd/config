{ config, pkgs, ... }:

let 
  unstable = import <nixpkgs-unstable> {};
in
{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    cht-sh
    direnv
    unstable.emacs
    fd
    fzf
    gopls
    unstable.neovim
    unstable.git-lfs
    rnix-lsp
    nmap
    ripgrep
    tldr
    trash-cli
    unstable.zoxide
  ];

  programs.home-manager.enable = true;
}
