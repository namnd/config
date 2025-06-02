{ pkgs, lib, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  xsession.enable = true;
  xsession.initExtra = ''
    xset r rate 250 60
    dwmblocks &!
  '';

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    fastfetch
    arandr

    neovim 
    awscli2
    aws-vault
    fzf
    fd
    ripgrep
    gcc
    ccls
    nixd
    bash-language-server
    lua-language-server
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


    kubectl
    kubernetes-helm
    terraform
    terraform-ls
    go
    gopls
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

  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
    userEmail = "me@namnd.com";
    signing = {
      key = "54D86DA33E656F30";
      signByDefault = true;
    };
    aliases = {
      undo = "!git reset HEAD~1 --mixed";
      graph = "!f()  { git log --graph --abbrev-commit --decorate --all; }; f";
    };
    extraConfig = {
      color = {
        ui = true;
        diff = true;
        status = true;
        branch = true;
        interactive = true;
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      rebase.autoStash = true;
      push.default = "current";
      format.pretty = "%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)";
      merge = {
        tool = "nvimdiff4";
        prompt = false;
      };
      mergetool.nvimdiff4.cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
    };
    ignores = [
      "Session.vim"
      ".direnv"
      "scratch*"
    ];
  };

  programs.bash = {
    enable = true;
    historyControl = ["ignoreboth"];
    initExtra = builtins.readFile ./bashrc;
    shellAliases = {
      vim = "nvim";
      ls = "ls --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
      ga = "git add --patch";
      gb = "git branch";
      gs = "git status";
      gc = "git checkout";
      gp = "git pull";
      gP = "git push";
      gd = "git diff";
      gl = "git log";
      gg = "git graph";
    };

  };

  programs.direnv = {
    enable = lib.mkDefault true;
    config = {
      global = {
        warn_timeout = "10m";
      };
    };
    nix-direnv = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
