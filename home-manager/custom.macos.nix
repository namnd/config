{ config, pkgs, ... }:
{

  programs.git.settings.user.email = "me@namnd.com";
  programs.git.signing = {
    key = "54D86DA33E656F30";
    signByDefault = true;
  };

  programs.gpg.enable = true;

  home.packages = with pkgs; [
    pass
    coreutils
  ];

  home.file = {
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink ../ghostty;
    ".config/hammerspoon".source = config.lib.file.mkOutOfStoreSymlink ../hammerspoon;
  };
}
