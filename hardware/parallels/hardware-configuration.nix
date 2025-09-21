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
    package = config.boot.kernelPackages.prl-tools.overrideAttrs (
      finalAttrs: previousAttrs: {
        version = "26.0.1-57243";
        src = previousAttrs.src.overrideAttrs {
          outputHash = "sha256-jAOP9g3JCKxOFyiDdYJvvM9ecGDbMuCARCEu4sE7Cfs=";
        };
      }
    );
  };

  environment.unfreePackages = [ "prl-tools" ];
}
