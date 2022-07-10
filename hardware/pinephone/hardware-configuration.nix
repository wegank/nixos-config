{ lib, pkgs, nur-pkgs, mobile-nixos-src, ... }:

{
  imports = [
    (import "${mobile-nixos-src}/lib/configuration.nix" {
      device = "pine64-pinephone";
    })
  ];

  boot.kernelPackages = lib.mkForce (
    pkgs.linuxPackagesFor nur-pkgs.linux_pinephone
  );
}
