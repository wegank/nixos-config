{ config, lib, pkgs, ... }:

{
  imports = [
    ./app/podman.nix
    ./app/qemu.nix
    ./app/vscode-server.nix
    ./net/openssh.nix
    ./net/xrdp.nix
    ./net/zerotier.nix
    ./sys/zram.nix
    ./xfce/xfce.nix
  ];
}
