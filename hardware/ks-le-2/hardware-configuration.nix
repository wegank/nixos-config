# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "usbhid"
        "usb_storage"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-intel"
    ];
    extraModulePackages = [ ];
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sdc";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
  };

  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces."eth0" = {
      ipv4.addresses = [{
        address = "37.187.92.65";
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = "2001:41d0:a:3441::1";
        prefixLength = 128;
      }];
    };
    defaultGateway = {
      address = "37.187.92.254";
      interface = "eth0";
    };
    defaultGateway6 = {
      address = "2001:41d0:000a:34ff:00ff:00ff:00ff:00ff";
      interface = "eth0";
    };
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = "ondemand";

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
}
