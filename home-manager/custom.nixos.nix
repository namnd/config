{ pkgs, ... }:
{
  xsession.enable = true;
  xsession.initExtra = ''
    xset r rate 250 60
    dwmblocks &!
  '';

  programs.git.userEmail = "me@namnd.com";
  programs.git.signing = {
    key = "54D86DA33E656F30";
    signByDefault = true;
  };


  home.packages = with pkgs; [
    arandr
    gcc
    ccls
    wget
    udisks
    unzip
    gnumake
    scrot

    surf
    atop
    btop
    htop
    scrot
    pavucontrol
    pulseaudio
    pass
    libnotify
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "DejaVu Sans 12";
      };
    };
  };

  programs.gpg.enable = true;

  programs.qutebrowser = {
    enable = true;
    settings = {
      content = {
        blocking.adblock.lists = [
          "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2024.txt"
          "https://easylist.to/easylist/easylist.txt"
          "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://easylist-downloads.adblockplus.org/liste_fr.txt"
          "https://easylist-downloads.adblockplus.org/ruadlist.txt"
          "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
        ];
      };
      fonts = {
        default_size = "14pt";
        web.size.default = 20;
      };
      colors.webpage.darkmode.enabled = true;
      zoom.default = "150%";
    };
    extraConfig = ''

    '';
  };
}
