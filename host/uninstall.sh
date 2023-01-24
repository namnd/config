#!/bin/sh

# Reference https://nixos.org/manual/nix/stable/installation/installing-binary.html#macos

function main() {
  remove_shell_rc
  remove_daemon_services
  remove_nixbld
  remove_the_rest
}

# Remove (backup) shell config
function remove_shell_rc() {
  sudo rm -rf /etc/{bashrc,zshrc,bash.bashrc}
  sudo rm -rf /etc/{bashrc,zshrc,bash.bashrc}.backup-before-nix
}

# Stop and remove the Nix daemon services
function remove_daemon_services() {
  if [ -f "/Library/LaunchDaemons/org.nixos.nix-daemon.plist" ]; then
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
  fi
  if [ -f "/Library/LaunchDaemons/org.nixos.darwin-store.plist" ]; then
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist
    sudo rm /Library/LaunchDaemons/org.nixos.darwin-store.plist
  fi
}

# Remove the nixbld group and the _nixbuildN users:
function remove_nixbld() {
  sudo dscl . -delete /Groups/nixbld
  for u in $(sudo dscl . -list /Users | grep _nixbld); do sudo dscl . -delete /Users/$u; done
}

# Edit fstab using sudo vifs to remove the line mounting the Nix Store volume on /nix,
# which looks like this, LABEL=Nix\040Store /nix apfs rw,nobrowse.
# This will prevent automatic mounting of the Nix Store volume.

function remove_the_rest() {
  sudo rm -rf /etc/synthetic.conf

  # Remove the files Nix added to your system
  sudo rm -rf /etc/nix /var/root/.nix-profile /var/root/.nix-defexpr /var/root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels

  # Remove the Nix Store volume
  sudo diskutil apfs deleteVolume /nix
}

main
