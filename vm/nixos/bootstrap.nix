{ pkgs, ... }: 
{
  users.users.username = {
    isNormalUser = true;
    home = "/home/username";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh_key" ];
  };

  networking.hostName = "vm_hostname";
  time.timeZone = "Australia/Sydney";
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gnumake
    vim
    xclip
  ];
}
