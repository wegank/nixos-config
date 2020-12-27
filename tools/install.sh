#!/run/current-system/sw/bin/bash
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart ESP fat32 1MiB 512MiB
parted -s /dev/sda set 1 esp on
parted -s /dev/sda mkpart primary ext4 512MiB 100%
yes | mkfs.fat -F 32 -n boot /dev/sda1
yes | mkfs.ext4 -L nixos /dev/sda2
sleep 5
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update
sleep 5
nixos-generate-config --root /mnt
cp configuration.nix /mnt/etc/nixos/
cp home.nix /mnt/etc/nixos/
nixos-install --no-root-passwd
