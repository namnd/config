# NixOS VM

## Prerequisites

* [UTM](https://mac.getutm.app/). This is free but still very good alternative to VMware Fusion.
* NixOS iso image. Download the [Aarch image](https://hydra.nixos.org/job/nixos/release-22.05-aarch64/nixos.iso_minimal.aarch64-linux) for M1. If you're on Intel chip, get the image from [here](https://nixos.org/download.html#nixos-iso) instead.

## Setup guide

1. Open UTM, create a new VM by choosing Virtualize > Linux, then select the iso image you downloaded above. Choose about 1/2 (8192 MB) for Memory and 2/3 (6) number of CPU Cores. 64 GB for Storage should be more than enough. Everything else you can leave as default.
2. Start up the VM to start the installation process. Change your root password to `root` by typing following command:

```
$ sudo -i
$ passwd
```

Check your VM ip address by typing the command `$ ip a`. Please save this ip address as it will be used for the next step

3. Clone this repo to your computer.

Update `user.mk` with your username and ssh public key. [See this](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) if you haven't already got one SSH key.

4. Inside the repo, set the environment using above ip address

```
$ export NIXADDR=ip_address

```
5. Run the installation by the command (enter `root` when prompt for password)

```
make install
```
Depends on your machine, this would take about 1-2 minutes. Once it's done, switch to UTM, clear out the Boot iso image, as we are no longer need it. Reboot the VM.

6. Once the VM is rebooted, within the repo, run command (enter `root` twice when prompt for password then type `yes` when prompt to accept the ssh key as authorization method)

```
$ make bootstrap
```

7. Now you should be able to `ssh` from your host machine to the VM

```
$ ssh -p22 user@$NIXADDR
```
