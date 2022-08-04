{ config, pkgs, lib, ... }:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # Neovim
    neovim
    trash-cli
    cht-sh
    ripgrep
    fd
    rnix-lsp                                    # Nix LSP
    sumneko-lua-language-server                 # Lua LSP
    zls                                         # Zig LSP

    # Other
    direnv
    fzf
    tldr
    tree
  ] ++ lib.optionals (isLinux) [
  ] ++ lib.optionals (isDarwin) [
    emacs
  ];

  programs.home-manager.enable = true;
  programs.gpg.enable = true;
}

