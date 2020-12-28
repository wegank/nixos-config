#!/run/current-system/sw/bin/bash
nixos-rebuild switch --upgrade --flake '.#parallels' --no-write-lock-file
