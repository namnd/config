{ pkgs, ... }:
{
  programs.git.userEmail = "me@namnd.com";
  programs.git.signing = {
    key = "54D86DA33E656F30";
    signByDefault = true;
  };

  home.packages = with pkgs; [
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

    fuzzel
    inotify-tools
    swaylock
    hyprpaper
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "DejaVu Sans 12";
      };
    };
  };

  programs.gpg.enable = true;

  programs.waybar = {
    enable = true;
  };

  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://www.google.com/search?hl=en&q={}";
      y = "https://youtube.com/results?search_query={}";
      x = "https://x.com/search?q={}";
      nixp = "https://search.nixos.org/packages?query={}";
      nixo = "https://search.nixos.org/options?query={}";
    };
    quickmarks = {
      gr = "https://grok.com";
      gh = "https://github.com";
      r = "https://reddit.com";
    };
    settings = {
      url.start_pages = ["https://google.com"];
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
