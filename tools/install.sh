#!/run/current-system/sw/bin/bash
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart ESP fat32 1MiB 512MiB
parted -s /dev/sda set 1 esp on
parted -s /dev/sda mkpart primary ext4 512MiB 100%
yes | mkfs.fat -F 32 -n boot /dev/sda1
yes | mkfs.ext4 -L nixos /dev/sda2
sleep 1
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
sleep 1
nixos-install --no-root-passwd --flake '.#parallels'
