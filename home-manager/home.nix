{ pkgs, lib, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.enableNixpkgsReleaseCheck = false;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    fastfetch

    neovim 
    awscli2
    aws-vault
    fzf
    fd
    ripgrep
    nixd
    bash-language-server
    lua-language-server

    kubectl
    kubernetes-helm
    terraform
    terraform-ls
    go
    gopls
  ];


  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
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

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
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
      v = "aws-vault exec --debug --backend=file --duration=1h";
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

  imports = [
    ./custom.nix
  ];
}
