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
    # AWS
    awscli2
    aws-vault

    # Neovim
    neovim
    trash-cli
    cht-sh
    ripgrep
    fd
    delve
    gopls                                       # Go LSP
    rnix-lsp                                    # Nix LSP
    sumneko-lua-language-server                 # Lua LSP
    nodePackages.pyright                        # Python LSP
    nodePackages.typescript-language-server     # Typescript LSP
    zls                                         # Zig LSP
    terraform-ls                                # HCL LSP

    # Other
    csvkit
    direnv
    fzf
    jq
    tldr
    tree
    pre-commit
  ] ++ lib.optionals (isLinux) [
    gcc
    zip
    unzip
  ] ++ lib.optionals (isDarwin) [
    coreutils
    emacs
  ];

  programs.home-manager.enable = true;
  programs.gpg.enable = true;
}

