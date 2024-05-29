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
    package = with pkgs; config.boot.kernelPackages.prl-tools.overrideAttrs (finalAttrs: previousAttrs: {
      version = "19.4.0-54962";
      src = fetchurl {
        url = "https://download.parallels.com/desktop/v${lib.versions.major finalAttrs.version}/${finalAttrs.version}/ParallelsDesktop-${finalAttrs.version}.dmg";
        hash = "sha256-c/MrWUvwY/Z38uOBbetJSVkZlwkdzFhw6wpk1L0BuQs=";
      };
    });
  };

  environment.unfreePackages = [
    "prl-tools"
  ];
}
