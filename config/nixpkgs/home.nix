{ config, pkgs, ... }:

{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # Neovim
    neovim
    trash-cli
    cht-sh
    ripgrep

    # LSP
    gopls                           # Go
    rnix-lsp                        # Nix
    sumneko-lua-language-server     # Lua
    nodePackages.pyright            # Python
    zls                             # Zig

    # Other
    direnv
    tldr
    emacs
  ];

  programs.home-manager.enable = true;
  programs.gpg.enable = true;
}

