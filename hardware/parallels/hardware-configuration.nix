# Hardware configuration.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

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
    package = pkgs.prl-tools.overrideAttrs (
      finalAttrs: previousAttrs: {
        version = "26.2.1-57371";
        src = previousAttrs.src.overrideAttrs {
          outputHash = "sha256-mmZsaLYaA9OjYwfZ75Be59n8Ve2DjdG6fGqgx8NpdLI=";
        };
      }
    );
  };

  environment.unfreePackages = [ "prl-tools" ];
}
