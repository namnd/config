{ config, pkgs, ... }:

{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    neovim
  ];

  programs.home-manager.enable = true;
  programs.gpg.enable = true;
}

