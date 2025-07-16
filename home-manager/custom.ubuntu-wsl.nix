{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # gnome-keyring doesn't work via home-manager https://github.com/nix-community/home-manager/issues/1454, so workaround below
  # > sudo apt install gnome-keyring
  # > secret-tool store --label='Work proxy password' purpose http_proxy location work
  programs.bash.profileExtra = ''
export {http,https,ftp}_proxy=$(secret-tool lookup purpose http_proxy location work)
export {HTTP,HTTPS,FTP}_PROXY=$(secret-tool lookup purpose http_proxy location work)
export no_proxy="localhost,.ap-southeast-2.eks.amazonaws.com"
export NO_PROXY="localhost,.ap-southeast-2.eks.amazonaws.com"
  '';

  home.packages = with pkgs; [
    gcc
    xclip
    jdk

    libsecret
  ];
}
