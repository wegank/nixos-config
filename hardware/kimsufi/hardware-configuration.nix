# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot = {
    initrd = {
      availableKernelModules = [
        "uhci_hcd"
        "ahci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
  };

  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces."eth0".ipv4.addresses = [{
      address = "5.39.78.26";
      prefixLength = 24;
    }];
    defaultGateway = {
      address = "5.39.78.254";
      interface = "eth0";
    };
    nameservers = [
      "8.8.8.8"
    ];
  };

  swapDevices = [ ];
}
