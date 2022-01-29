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
        owner = "wegank";
        repo = "vendor_oneplus";
        rev = "7aef37d27edb780fd667735abd579ab16d7d77af";
        sha256 = "sha256-IX68oMLk8134wXEB2OxFqj+ySD6UesYLH6Vocv01xj8=";
        fetchSubmodules = true;
      };

      /*
      source.dirs."vendor/oneplus/addons/camera".src = pkgs.fetchFromGitLab {
        owner = "chandu078";
        repo = "vendor_oneplus_addons_camera";
        rev = "f62da8225eb82b6f59359b9f81a51fd931981de8";
        sha256 = "sha256-VxlUsvXjM9fFueOW8FzMQdifHVJ9aWkgF13tkjOg9Sk=";
      };
      */

      ccache.enable = true;
    });

    defaultPackage.aarch64-linux = self.robotnixConfigurations."lemonades".img;
  };
}
