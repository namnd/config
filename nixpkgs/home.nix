{ config, pkgs, ... }:

{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
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
    nodejs
    ripgrep
    tmux
    trash-cli
    tree-sitter
  ];

  programs.home-manager.enable = true;
}
