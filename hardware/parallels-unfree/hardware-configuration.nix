# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  disabledModules = [ "virtualisation/parallels-guest.nix" ];

  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./parallels-guest.nix
  ];

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
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  hardware.parallels = {
    enable = true;
    package = (config.boot.kernelPackages.callPackage ./prl-tools.nix { });
  };

  environment.unfreePackages = [
    "prl-tools"
  ];
}
