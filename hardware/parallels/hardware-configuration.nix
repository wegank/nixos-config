# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

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

  hardware.parallels = {
    enable = true;
    package = with pkgs; (config.boot.kernelPackages.prl-tools.overrideAttrs (old:
      let
        version = "18.0.3-53079";
        src = fetchurl {
          url = "https://download.parallels.com/desktop/v${lib.versions.major version}/${version}/ParallelsDesktop-${version}.dmg";
          sha256 = "sha256-z9B2nhcTSZr3L30fa54zYi6WnonQ2wezHoneT2tQWAc=";
        };
        patches = lib.optionals (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.0") [
          ./prl-tools-6.0.patch
        ];
        unpackPhase = ''
          undmg "${src}"
          export sourceRoot=prl-tools-build
          7z x "Parallels Desktop.app/Contents/Resources/Tools/prl-tools-lin-arm.iso" -o$sourceRoot
          if test -z "$libsOnly"; then
            ( cd $sourceRoot/kmods; tar -xaf prl_mod.tar.gz )
          fi
        '';
      in
      { inherit version src patches unpackPhase; }
    ));
  };

  systemd.services.prlshprint.serviceConfig.Type = lib.mkForce "simple";

  environment.unfreePackages = [
    "prl-tools"
  ];
}
