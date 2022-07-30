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
    jq
    go_1_18
    gopls                           # Go LSP
    rnix-lsp                        # Nix LSP
    sumneko-lua-language-server     # Lua LSP
    nodePackages.pyright            # Python LSP
    zls                             # Zig LSP
    neovim
    unstable.git-lfs
    nmap
    ripgrep
    tldr
    trash-cli
    unstable.zoxide
  ];

  programs.home-manager.enable = true;
}
