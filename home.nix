{ config, pkgs, lib, ... }:

let
  isVm = pkgs.stdenv.hostPlatform.isLinux;
  isHost = pkgs.stdenv.hostPlatform.isDarwin;
  unstable = import <nixos-unstable> {};
in
{
  home.enableNixpkgsReleaseCheck = false;
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  manual.manpages.enable = false;

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.gpg.enable = true;

  home.packages = with pkgs; [
    awscli2
    neovim
    pass
    lemonade
    unstable.fzf
    fd
    ripgrep
    nodejs_18
    tldr
    tree
    jq
    aws-vault
    coreutils
    wget
  ] ++ lib.optionals (isVm) [
    cht-sh
    csvkit
    hugo
    gcc
    unzip
    btop
  ] ++ lib.optionals (isHost) [
    docker
    colima
  ];

  programs.direnv = {
    enable = lib.mkDefault false;
    config = {
      global = {
        warn_timeout = "10m";
      };
    };
    nix-direnv = {
      enable = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
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
    ] ++ lib.optionals (isHost) [
      ".DS_Store"
    ];
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    dotDir = "./.config/zsh";
    history = {
      expireDuplicatesFirst = true;
      save = 10000;
      share = true;
      size = 10000;
    };
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      vim = "nvim";
      ls = "ls --color=auto";
      ll = "ls -l";
      all = "ls -al";
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
      gw = "git worktree";
      mcd = "f() { mkdir -p $1 && cd $1 }; f";
      v = "aws-vault exec --debug --backend=file --duration=1h";
      ssh = "ssh -R 2489:127.0.0.1:2489"; # lemonade server
      work = "ssh namnguyen@192.168.71.7";
      work2 = "ssh namnguyen@192.168.71.15";
      psql = "PAGER=\"nvim -c 'set nomod nolist nowrap syntax=sql'\" psql";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  imports = [
    ./custom.nix
  ];
}

