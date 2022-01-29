{
  description = "Build LineageOS for OnePlus 9R";

  inputs.robotnix.url = "github:danielfullmer/robotnix";

  outputs = { self, robotnix }: {
    robotnixConfigurations."lemonades" = robotnix.lib.robotnixSystem ({ config, pkgs, ... }: {
      device = "lemonades";
      flavor = "lineageos";
      androidVersion = 11;

      apps.chromium.enable = false;
      webview.chromium.enable = false;

      source.dirs."device/oneplus/lemonades".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "device_oneplus_lemonades";
        rev = "fae2e4efa49efea80af632d00762b6acd6b5cbff";
        sha256 = "sha256-CyXIwRRCoCFYB+jDXgFbY83bx35zv3wtNJgZT4Hjqnw=";
      };

      source.dirs."kernel/oneplus/sm8250".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "kernel_oneplus_sm8250";
        rev = "da96fc8381685b615f045014b7e1175494c1cd2d";
        sha256 = "sha256-fVptlGq9Ng1Uv5EQl+m2taIPPDqkiwT9lxo3EUweqTE=";
      };

      source.dirs."hardware/oneplus".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "hardware_oneplus";
        rev = "6ee77f3f666fd3698a74d99eb12b0eeab575da71";
        sha256 = "sha256-+Z9ariao/KuEgWND3XJ5vJAUWRseFJY9VvnoUj9wvCM=";
      };

      source.dirs."vendor/oneplus".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "proprietary_vendor_oneplus";
        rev = "6c13fdcc88117365bf8ef37ebf337a4bda227a70";
        sha256 = "sha256-CyGb0+GGhiFOsfSvM1hZxgCYpVjzevy4AMQZ2xDNFYI=";
      };

      ccache.enable = true;
    });

    defaultPackage.aarch64-linux = self.robotnixConfigurations."lemonades".img;
  };
}
