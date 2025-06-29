{ pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  users.users.namnguyen = {
    isNormalUser = true;
    description = "Nam Nguyen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  programs.ssh.startAgent = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
      };
      initial_session = {
        command = "Hyprland";
        user = "namnguyen";
      };
    };
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ghostty
    wl-clipboard
    cliphist
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
