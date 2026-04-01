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
        "uas"
        "usb_storage"
        "vc4"
        "pcie-brcmstb"
        "xhci-pci-renesas"
        "reset-raspberrypi"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    blacklistedKernelModules = [
      "r8188eu"
      "rtl8xxxu"
    ];
    extraModulePackages = [
      (config.boot.kernelPackages.rtl8188eus-aircrack.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "gglluukk";
          repo = "rtl8188eus";
          rev = "52bd147aac056a865bfa1e52375c3cffd93364ec";
          hash = "sha256-euh+aWxCxmC3cW7AP9ZssZJckp4rz4picYqy33rJ6AI=";
        };
        meta.broken = false;
      })
    ];
    loader = {
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

  powerManagement.cpuFreqGovernor = "ondemand";

  # Wi-Fi
  hardware.enableRedistributableFirmware = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA1.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA1 -P bcm -S 3000000";
    };
  };
}
