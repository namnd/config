{ config, pkgs, lib, ... }:

let
  isVm = pkgs.stdenv.hostPlatform.isLinux;
  isHost = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
  programs.gpg.enable = true;

  home.packages = with pkgs; [
    neovim
    lemonade
  ] ++ lib.optionals (isVm) [
    awscli2
    aws-vault
    cht-sh
    coreutils
    csvkit
    jq
    fd
    fzf
    tldr
    tree
    hugo
    ripgrep
    rnix-lsp
    gcc
    unzip
    gh
  ] ++ lib.optionals (isHost) [
    pass
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
    };
    ignores = [
      "Session.vim"
      ".direnv"
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
      gs = "git status";
      gc = "git checkout";
      gp = "git pull";
      gP = "git push";
      gd = "git diff";
      gl = "git log";
      gg = "git graph";
      gb = "_git_branch";
      gL = "_git_log";
      mcd = "f() { mkdir -p $1 && cd $1 }; f";
      v = "aws-vault exec --debug --backend=file --duration=1h";
      ssh = "ssh -R 2489:127.0.0.1:2489"; # lemonade server
    };
  };

  programs.kitty = {
    enable = lib.mkDefault false;
    font = {
      name = "Monaco";
      size = 18;
    };
    settings = {
      tab_bar_edge = "top";
      tab_bar_style = "custom";
      tab_title_template = "{index}: {title}";
      inactive_tab_background = "#666";
      inactive_tab_foreground = "#333";
      shell_integration = "no-title";
      macos_option_as_alt = true;
      enabled_layouts = "tall,fat,stack";
    };
    keybindings = {
      "cmd+n" = "launch --cwd=current";
      "cmd+l" = "next_layout";
      "cmd+z" = "toggle_layout stack";
      "cmd+w" = "close_window";
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+]" = "next_tab";
      "cmd+[" = "previous_tab";
      "cmd+shift+]" = "next_window";
      "cmd+shift+[" = "previous_window";
      "cmd+shift+t" = "new_tab_with_cwd";
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

