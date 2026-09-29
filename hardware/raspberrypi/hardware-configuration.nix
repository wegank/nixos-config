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
    kernelParams = [
      "iomem=relaxed"
    ];
    blacklistedKernelModules = [
      "r8188eu"
      "rtl8xxxu"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.rtl8188eus-aircrack
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

  # A recent bump of wpa_supplicant from 2.11 to 2.12 breaks Wi-Fi on Raspberry Pi 4.
  # This overlay pins wpa_supplicant to 2.11 and applies the patches from the last working NixOS generation.
  nixpkgs.overlays = [
    (
      _: prev:
      let
        oldPatch =
          name: hash:
          prev.fetchurl {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/d6524aaca2ff07876657ae2b323f24be4874944b/pkgs/by-name/wp/wpa_supplicant/${name}.patch";
            inherit hash;
          };
      in
      {
        wpa_supplicant = prev.wpa_supplicant.overrideAttrs (_: {
          version = "2.11";
          src = prev.fetchurl {
            url = "https://w1.fi/releases/wpa_supplicant-2.11.tar.gz";
            hash = "sha256-kS6gb3TjCo42+7aAZNbN/yGNjVkdsPxddd7myBrH/Ao=";
          };
          # Match the patches from the last working 2.11 NixOS generation.
          patches = [
            (prev.fetchpatch {
              name = "revert-change-breaking-auth-broadcom.patch";
              url = "https://w1.fi/cgit/hostap/patch/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5";
              hash = "sha256-X6mBbj7BkW66aYeSCiI3JKBJv10etLQxaTRfRgwsFmM=";
              revert = true;
            })
            (prev.fetchpatch {
              name = "suppress-ctrl-event-signal-change.patch";
              url = "https://w1.fi/cgit/hostap/patch/?id=c330b5820eefa8e703dbce7278c2a62d9c69166a";
              hash = "sha256-5ti5OzgnZUFznjU8YH8Cfktrj4YBzsbbrEbNvec+ppQ=";
            })
            (prev.fetchpatch {
              name = "ensure-full-key-match.patch";
              url = "https://git.w1.fi/cgit/hostap/patch/?id=1ce37105da371c8b9cf3f349f78f5aac77d40836";
              hash = "sha256-leCk0oexNBZyVK5Q5gR4ZcgWxa0/xt/aU+DssTa0UwE=";
            })
            (oldPatch "unsurprising-ext-password" "sha256-T+AYfeUYDCeEra5urOUwDniEtkyZnTgqYIbkFYZG1NQ=")
            (oldPatch "multiple-configs" "sha256-tO6sW1Y5gdJbLNizXLz69Pbxg55a5LkuUN1Hh+xt9Gs=")
            (oldPatch "unprivileged-daemon" "sha256-HPsyoLoBR57X8E/VYp7pqYxpYMqqmAwpYC8s50vxcro=")
          ];
        });
      }
    )
  ];

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
