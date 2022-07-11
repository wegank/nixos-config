{ lib, pkgs, nur-pkgs, ... }:

{
  boot = {
    kernelPackages = lib.mkForce
      (pkgs.linuxPackagesFor nur-pkgs.linux_pinephone);
    kernelParams = [
      # Serial console on ttyS0, using the serial headphone adapter.
      "console=ttyS0,115200"
      "vt.global_cursor_default=0"
      "earlycon=uart,mmio32,0x01c28000"
      "panic=10"
      "consoleblank=0"
    ];
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

  hardware = {
    enableRedistributableFirmware = true;
    firmware = [
      nur-pkgs.pinephone-firmware
    ];
  };

  systemd = {
    packages = [
      nur-pkgs.eg25-manager
    ];
    targets.multi-user.wants = [
      "eg25-manager.service"
    ];
  };

  services = {
    dbus.packages = [
      nur-pkgs.eg25-manager
    ];
  };
}
