#!/run/current-system/sw/bin/bash
cp configuration.nix /etc/nixos/
cp home.nix /etc/nixos/
nixos-rebuild switch --upgrade
