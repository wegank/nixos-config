#!/run/current-system/sw/bin/bash
cp configuration.nix /mnt/etc/nixos/
cp home.nix /mnt/etc/nixos/
nixos-rebuild switch --upgrade
