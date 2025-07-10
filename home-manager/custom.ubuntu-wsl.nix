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
export no_proxy="localhost,127.0.0.*,10.*,192.168.*,172.16.*,172.17.*,172.18.*,172.19.*,172.20.*,172.21.*,172.22.*,172.23.*,172.24.*,172.25.*,172.26.*,172.27.*,172.28.*,172.29.*,172.30.*,172.31.*,*.*.ap-southeast-2.eks.amazonaws.com"
export NO_PROXY="localhost,127.0.0.*,10.*,192.168.*,172.16.*,172.17.*,172.18.*,172.19.*,172.20.*,172.21.*,172.22.*,172.23.*,172.24.*,172.25.*,172.26.*,172.27.*,172.28.*,172.29.*,172.30.*,172.31.*,*.*.ap-southeast-2.eks.amazonaws.com"
  '';

  home.packages = with pkgs; [
    gcc
    xclip
    jdk

    libsecret
  ];

  programs.bash.shellAliases.k = "https_proxy= HTTPS_PROXY= kubectl";
  programs.bash.shellAliases.h = "https_proxy= HTTPS_PROXY= helm";
}
