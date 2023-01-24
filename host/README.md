# MacOS host

WIP

TL;DR

```bash
# Install nix
$ sh -c "$(curl -L https://releases.nixos.org/nix/nix-2.8.1/install)" --daemon

# Install home-manager
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
$ nix-channel --update
$ export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
$ nix-shell '<home-manager>' -A install

# Clone nixos repo
git clone https://github.com/namnd/nixos

# Setup host
cd nixos/host && sh init.sh
```

