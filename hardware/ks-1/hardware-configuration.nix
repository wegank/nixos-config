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
    interfaces."eth0" = {
      ipv4.addresses = [{
        address = "5.39.78.26";
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = "2001:41d0:8:901a::1";
        prefixLength = 128;
      }];
    };
    defaultGateway = {
      address = "5.39.78.254";
      interface = "eth0";
    };
    defaultGateway6 = {
      address = "2001:41d0:0008:90ff:00ff:00ff:00ff:00ff";
      interface = "eth0";
    };
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  swapDevices = [ ];
}
