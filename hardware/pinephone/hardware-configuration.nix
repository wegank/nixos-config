{ lib, pkgs, mobile-nixos-src, ... }:

{
  imports = [
    (import "${mobile-nixos-src}/lib/configuration.nix" {
      device = "pine64-pinephone";
    })
  ];

  boot.kernelPackages = lib.mkForce (
    pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor (
      pkgs.callPackage ./linux-pinephone.nix {
        inherit mobile-nixos-src;
      }
    ))
  );
}
