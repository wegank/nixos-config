# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  
  boot = {
    initrd = {
      availableKernelModules = [ 
        "uhci_hcd" 
        "xhci_pci" 
        "ehci_pci" 
        "ata_piix" 
        "sd_mod" 
        "sr_mod" 
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
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
}
