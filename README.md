# NixOS

My NixOS configuration.


## VM guest

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
