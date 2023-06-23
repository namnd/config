{ pkgs, ... }:
{
  users.users.username = {
    isNormalUser = true;
    home = "/home/username";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8HjC+29D66x0zOMMwrleHKHN4bD5hBmIqKzc3FALQo" ];
  };

  # tailscale
  services.tailscale.enable = true;
  networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  networking.search = [ "tail188aa.ts.net" ];
  networking.firewall.enable = false;

  networking.hostName = "vm_hostname";
  time.timeZone = "Australia/Brisbane";
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gnumake
    vim
    xclip
    gnupg
  ];

  programs.zsh.enable = true;
  programs.ssh.startAgent = false;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
    enableSSHSupport = true;
  };

}
