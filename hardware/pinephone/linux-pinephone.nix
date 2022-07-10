{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, fetchurl
, buildLinux
, ...
} @ args:

let
  rev = "de9a88a70f0ae5fc0839ff94bf29e8a30af399f8";
in
lib.overrideDerivation
  (buildLinux (args // {
    version = "5.17.5";

    src = fetchFromGitHub {
      # https://github.com/megous/linux
      owner = "megous";
      repo = "linux";
      # orange-pi-5.17
      rev = "3508d5fd2af1b74c370f86863aa99933537826b6";
      sha256 = "sha256-KfA9MeZL1cogkXYn8n2Vuk+W5S8EaX9e1q03JTH8YGI=";
    };

    defconfig = "pinephone_defconfig";

    kernelPatches = [
      {
        name = "setup-default-on-and-panic-leds";
        patch = fetchpatch {
          url = "https://raw.githubusercontent.com/NixOS/mobile-nixos/${rev}/devices/pine64-pinephone/kernel/0001-dts-pinephone-Setup-default-on-and-panic-LEDs.patch";
          sha256 = "sha256-Gat478Po6DD+fwn79XmxW0thbJdI33lSHQdVkne+6OA=";
        };
      }
      {
        name = "configure-128mib-cma";
        patch = fetchpatch {
          url = "https://github.com/mobile-nixos/linux/commit/372597b5449b7e21ad59dba0842091f4f1ed34b2.patch";
          sha256 = "1lca3fdmx2wglplp47z2d1030bgcidaf1fhbnfvkfwk3fj3grixc";
        };
      }
      {
        name = "drop-modem-power-node";
        patch = fetchpatch {
          url = "https://gitlab.com/postmarketOS/pmaports/-/raw/164e9f010dcf56642d8e6f422a994b927ae23f38/device/main/linux-postmarketos-allwinner/0007-dts-pinephone-drop-modem-power-node.patch";
          sha256 = "nYCoaYj8CuxbgXfy5q43Xb/ebe5DlJ1Px571y1/+lfQ=";
        };
      }
    ];
  } // (args.argsOverride or { })))
  (oldAttrs: {
    # Install *only* the desired FDTs
    postFixup = ''
      echo ":: Installing FDTs"
      mkdir -p "$out/dtbs/allwinner"
      cp -v $buildRoot/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-*.dtb $out/dtbs/allwinner/
    '';
  })
