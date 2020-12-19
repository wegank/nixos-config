# nixos-config

```bash
sudo parted /dev/sda -- mklabel gpt
sudo parted /dev/sda -- mkpart primary 512MiB 100%
sudo parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sda -- set 2 esp on
sudo mkfs.ext4 -L nixos /dev/sda1
sudo mkfs.fat -F 32 -n boot /dev/sda2
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo nixos-generate-config --root /mnt
sudo nano /mnt/etc/nixos/configuration.nix
sudo nixos-install
sudo reboot
```

