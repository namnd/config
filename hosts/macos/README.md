# Home

WIP

## Host - MacOS

Applications are downloaded and installed manually.

* [ghostty](https://ghostty.org/)
* [hammerspoon](https://www.hammerspoon.org/)
* [maccy](https://maccy.app/)
* [utm](https://mac.getutm.app/)

Run `./host/install.sh` script to create symlinks for configuration files.

Once in a while, run `./host/cleanup.sh` script to clean up some storage.

## Virtual Machine - NixOS

Skip step 1-3 if you already have a NixOS VM UTM template, which can be downloaded from [here](https://archive.org/download/nixos-24.11-arm64.utm/nixos-24.11-arm64.utm.zip)

1. Use UTM to create a new VM with the following settings:

    * Custom: Virtualize
    * Preconfigured: Linux
    * Boot ISO Image: download minimal ISO image from [NixOS](https://channels.nixos.org/nixos-24.11/latest-nixos-minimal-aarch64-linux.iso)
    * Memory: `10240` (on 16GB host)
    * CPU: `8` (on 10-core host)
    * Disk: `100GB`
    * Name: `NixOS`
    * Network: `Emulated VLAN` with Port Forwarding on port 22

2. Start the VM and set root password as `root`

```bash
$ sudo -i
$ passwd
```

3. From this repo, run command to install NixOS

```bash
$ make install
```

Once finish installing, shutdown the VM, remove bootable ISO, then start the VM again.

4. Check out the `Makefile` and `./vm/bootstrap.nix` and make necessary changes to your custom details, then run command

```bash
$ make bootstrap
```

And it's good to go!
