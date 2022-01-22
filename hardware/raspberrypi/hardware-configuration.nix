# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

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
    extraModulePackages = [ ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
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

  system.activationScripts.firmware-update =
    let configTxt = pkgs.writeText "config.txt" ''
      [pi4]
      kernel=u-boot-rpi4.bin
      enable_gic=1
      armstub=armstub8-gic.bin
      disable_overscan=1
      [all]
      arm_64bit=1
      enable_uart=1
      avoid_warnings=1
    '';
    in
    ''
      (cd ${pkgs.raspberrypifw}/share/raspberrypi/boot && cp bootcode.bin fixup*.dat start*.elf /boot/)
      # Add the config
      cp ${configTxt} /boot/config.txt
      # Add pi4 specific files
      cp ${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin /boot/u-boot-rpi4.bin
      cp ${pkgs.raspberrypi-armstubs}/armstub8-gic.bin /boot/armstub8-gic.bin
      cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2711-rpi-4-b.dtb /boot/
    '';

  hardware.enableRedistributableFirmware = true;
}
