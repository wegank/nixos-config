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
        version = "26.1.2-57293";
        src = previousAttrs.src.overrideAttrs {
          outputHash = "sha256-0sL6uKYw/D7gYYZyAWkxcP/KbJ1rBnlXIKYDu6MlTLQ=";
        };
      }
    );
  };

  environment.unfreePackages = [ "prl-tools" ];
}
