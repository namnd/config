# NixOS

## NixOS

WIP

## Virtual Machine (MacOS host)

TL;DR

```bash
# Guest VM
$ sudo -i
$ passwd
$ ip a

# Host
$ export NIXADDR=ip_address
$ make install
# Reboot VM, remove bootable iso, then
$ make bootstrap
```

## Ghostty

Copy Ghostty's terminfo to a remote machine
```
infocmp -x | ssh $NIXADDR -- tic -x -
```

https://github.com/ghostty-org/ghostty?tab=readme-ov-file#copy-ghosttys-terminfo-to-a-remote-machine
