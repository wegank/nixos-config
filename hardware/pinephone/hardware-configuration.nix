{ lib, pkgs, nur-pkgs, mobile-nixos-src, ... }:

let
  kernelPackages = pkgs.linuxPackagesFor nur-pkgs.linux_pinephone;
in
{
  imports = [
    (import "${mobile-nixos-src}/lib/configuration.nix" {
      device = "pine64-pinephone";
    })
  ];

  boot.kernelPackages = lib.mkForce kernelPackages;

  mobile.boot.stage-1.kernel = {
    package = lib.mkForce kernelPackages.kernel;
    useNixOSKernel = true;
  };
}
