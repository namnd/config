{ config, pkgs, ... }:

{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    direnv
    fzf
    jq
    go
    gopls
    gvproxy
    kitty
    neovim
    rnix-lsp
    podman
    podman-compose
    ripgrep
    tmux
    trash-cli
    tree-sitter
  ];

  programs.home-manager.enable = true;
}
