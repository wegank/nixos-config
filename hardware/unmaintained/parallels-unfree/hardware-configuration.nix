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

  networking.interfaces.enp0s5.useDHCP = true;

  nixpkgs.config.allowUnfree = true;
  hardware.parallels = {
    enable = true;
    package = (config.boot.kernelPackages.callPackage ./prl-tools.nix {});
  };
}
