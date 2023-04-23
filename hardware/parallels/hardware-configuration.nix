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
      version = "18.2.0-53488";
      src = fetchurl {
        url = "https://download.parallels.com/desktop/v${lib.versions.major version}/${version}/ParallelsDesktop-${version}.dmg";
        hash = "sha256-FpAbQQapIcZ7GsGjH4ZeJ81Ke+NUF7GvgV1wEDLKoUU=";
      };
      /*
        patches = lib.optionals (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.0") [
        ./prl-tools-6.0.patch
        ];
      */
      env.NIX_CFLAGS_COMPILE = lib.optionalString (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.3")
        "-Wno-incompatible-pointer-types";
    });
  };

  systemd.services.prlshprint.serviceConfig.Type = lib.mkForce "simple";

  environment.unfreePackages = [
    "prl-tools"
  ];
}
