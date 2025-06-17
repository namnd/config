{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    gcc
    xclip
  ];

  programs.bash.shellAliases.k = "https_proxy= HTTPS_PROXY= kubectl";
}
