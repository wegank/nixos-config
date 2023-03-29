# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

let
  ipv4 = "37.187.92.65";
  ipv4Gateway = "37.187.92.254";
  ipv6 = "2001:41d0:a:3441::1";
  ipv6Gateway = "2001:41d0:000a:34ff:00ff:00ff:00ff:00ff";
in
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
        device = "/dev/sda";
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
        address = ipv4;
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = ipv6;
        prefixLength = 128;
      }];
    };
    defaultGateway = {
      address = ipv4Gateway;
      interface = "eth0";
    };
    defaultGateway6 = {
      address = ipv6Gateway;
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
