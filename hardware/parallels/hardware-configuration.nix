# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "sr_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    kernelParams = [
      "root=/dev/sda2"
      "xhci_hcd.quirks=0x40"
    ];
    extraModulePackages = [ ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  hardware.parallels = {
    enable = true;
    package = with pkgs; config.boot.kernelPackages.prl-tools.overrideAttrs (old: rec {
      version = "19.1.0-54729";
      src = fetchurl {
        url = "https://download.parallels.com/desktop/v${lib.versions.major version}/${version}/ParallelsDesktop-${version}.dmg";
        hash = "sha256-Qo/6EuILu5i3hjhxecf3qfoMFEJHJZVY19tDIXDJiag=";
      };
    });
  };

  environment.unfreePackages = [
    "prl-tools"
  ];
}
