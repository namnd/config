# Forked from https://github.com/mitchellh/nixos-config

include config.mk

NIXADDR ?= unset
NIXPORT ?= 22

GPG_SUBKEYS ?= /Volumes/namnd/gpg-subkeys.txt
KEYGRIP ?= ECC7FCDCAB73B03C6DB54DDB04C88772536E20ED

# The block device prefix to use.
#   - sda for SATA/IDE
#   - vda for virtio
NIXBLOCKDEVICE ?= vda

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# SSH options that are used. These aren't meant to be overridden but are
# reused a lot so we just store them up here.
SSH_OPTIONS=-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# bootstrap a brand new VM. The VM should have NixOS ISO on the CD drive
# and just set the password of the root user to "root". This will install
# NixOS. After installing NixOS, you must reboot and set the root password
# for the next step.
# Reference: https://nixos.org/manual/nixos/stable/index.html#sec-installation-summary
install:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
		parted /dev/$(NIXBLOCKDEVICE) -- mklabel gpt; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary 512MiB -8GiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary linux-swap -8GiB 100\%; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart ESP fat32 1MiB 512MiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- set 3 esp on; \
		mkfs.ext4 -L nixos /dev/$(NIXBLOCKDEVICE)1; \
		mkswap -L swap /dev/$(NIXBLOCKDEVICE)2; \
		swapon /dev/$(NIXBLOCKDEVICE)2; \
		mkfs.fat -F 32 -n boot /dev/$(NIXBLOCKDEVICE)3; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nixos-generate-config --root /mnt; \
		sed --in-place '/system\.stateVersion = .*/a \
			services.openssh.enable = true;\n \
			services.openssh.settings.PasswordAuthentication = true;\n \
			services.openssh.settings.PermitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd; \
		"

bootstrap:
	$(MAKE) rebuild
	$(MAKE) secrets
	$(MAKE) home-manager
	$(MAKE) neovim

rebuild:
	rsync -av -e 'ssh $(SSH_OPTIONS)' \
		$(MAKEFILE_DIR)/vm/ root@$(NIXADDR):/etc/nixos
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
		ln -sf sh /bin/bash; \
		sh /etc/nixos/build.sh $(NIXUSER) $(VM_HOSTNAME); \
		"

# copy our secrets into the VM
secrets:
	# GPG keyring
	rsync -av -e 'ssh -p$(NIXPORT)' \
	$(GPG_SUBKEYS) $(NIXUSER)@$(NIXADDR):~/
	ssh $(NIXUSER)@$(NIXADDR) " \
		rm -rf ~/.gnupg; \
		gpg --import ~/gpg-subkeys.txt; \
		rm ~/gpg-subkeys.txt; \
		echo $(KEYGRIP) > ~/.gnupg/sshcontrol; \
		"

home-manager:
	ssh $(NIXUSER)@$(NIXADDR) " \
		git clone https://github.com/namnd/home-manager ~/.config/home-manager; \
		sed -i 's/https:\/\/github.com\/namnd\/home-manager/git@github.com:namnd\/home-manager.git/g' \
		~/.config/home-manager/.git/config; \
		cd ~/.config/home-manager && sh install.sh; \
		"

neovim:
	ssh $(NIXUSER)@$(NIXADDR) " \
		git clone https://github.com/namnd/nvim ~/.config/nvim; \
		sed -i 's/https:\/\/github.com\/namnd\/nvim/git@github.com:namnd\/nvim.git/g' \
		~/.config/nvim/.git/config; \
		"
