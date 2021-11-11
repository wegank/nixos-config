# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];
  
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

  networking.interfaces.enp0s5.useDHCP = true;
}
