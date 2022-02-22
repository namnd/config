{ config, pkgs, ... }:

{
  home.username = "namnguyen";
  home.homeDirectory = "/Users/namnguyen";

  home.stateVersion = "22.05";

  home.packages = [
    pkgs.direnv
    pkgs.jq
    pkgs.fzf
    pkgs.go
    pkgs.gopls
    pkgs.gvproxy
    pkgs.podman
    pkgs.podman-compose
  ];

  programs.home-manager.enable = true;
}
