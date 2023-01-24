{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
  programs.gpg.enable = true;
  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
    userEmail = "me@namnd.com";
    signing = {
      key = "3E656F30";
      signByDefault = true;
    };
  };

  home.packages = with pkgs; [
    pass
    lemonade
    hugo
    neovim
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ssh = "kitty +kitten ssh -R 2489:127.0.0.1:2489";
    };
  };
}

