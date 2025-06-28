{ config, ... }:
{

  home.file = {
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink ../ghostty;
    ".config/hammerspoon".source = config.lib.file.mkOutOfStoreSymlink ../hammerspoon;
  };
}
