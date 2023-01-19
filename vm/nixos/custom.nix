{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
    userEmail = "git_email";
    signing = {
      key = "3E656F30";
      signByDefault = true;
    };
  };
}

