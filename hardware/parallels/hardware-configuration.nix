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
        "sr_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    kernelParams = [
      "root=/dev/sda2"
      "xhci_hcd.quirks=0x40"
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
      fsType = "btrfs";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  hardware.parallels = {
    enable = true;
    package = config.boot.kernelPackages.prl-tools.overrideAttrs (
      finalAttrs: previousAttrs: {
        version = "20.2.0-55872";
        src = previousAttrs.src.overrideAttrs {
          outputHash = "sha256-oOilbF5MzZxZXNVQYAp/JxyMVdM0oltG8pGfzzsQ1kY=";
        };
        installPhase =
          builtins.replaceStrings
            [
              "cp prl_fs/SharedFolders/Guest/Linux/prl_fs/prl_fs.ko $out/lib/modules/${config.boot.kernelPackages.kernel.modDirVersion}/extra"
              "mkdir -p $out/share/man/man8"
              "install -Dm644 ../mount.prl_fs.8 $out/share/man/man8"
            ]
            [
              ""
              ""
              ""
            ]
            previousAttrs.installPhase;
      }
    );
  };

  environment.unfreePackages = [ "prl-tools" ];
}
