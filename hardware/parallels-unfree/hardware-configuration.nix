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

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "prl-tools"
  ];

  hardware.parallels = {
    enable = true;
    package = (config.boot.kernelPackages.callPackage ./prl-tools.nix { });
  };

  # Linux kernel 5.16.14 is broken on Apple hypervisor.
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_16.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
        sha256 = "1fvz4v3mcm9yxfak6mshl764piadgz46y71wprb85b1shc09i2ig";
      };
      version = "5.16.13";
      modDirVersion = "5.16.13";
    };
  });
}
