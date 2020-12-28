#!/run/current-system/sw/bin/bash
git clone . /tmp/nixos-config
nixos-generate-config --dir /tmp/nixos-config
git -C /tmp/nixos-config add .
git -C /tmp/nixos-config -c user.name='x' -c user.email='x' commit -m "Upgrade"
nixos-rebuild switch --upgrade --flake '/tmp/nixos-config/.' --no-write-lock-file
rm -rf /tmp/nixos-config
