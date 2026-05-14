{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  programs.bash.profileExtra = ''
export ALL_PROXY=http://127.0.0.1:3128
export HTTP_PROXY=http://127.0.0.1:3128
export HTTPS_PROXY=http://127.0.0.1:3128
export FTP_PROXY=http://127.0.0.1:3128
export all_proxy=http://127.0.0.1:3128
export http_proxy=http://127.0.0.1:3128
export https_proxy=http://127.0.0.1:3128
export ftp_proxy=http://127.0.0.1:3128
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  '';

  home.packages = with pkgs; [
    gcc
    xclip
    jdk

    libsecret
  ];
}
