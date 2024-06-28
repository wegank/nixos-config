{
  description = "Build LineageOS for OnePlus 9R";

  inputs.robotnix.url = "github:danielfullmer/robotnix";
  # inputs.robotnix.url = "./robotnix";
  # TODO: patch /pkgs.utillinux/ with /pkgs.pkgsCross.aarch64-multiplatform.utillinux/

  outputs =
    { self, robotnix }:
    {
      robotnixConfigurations."lemonades" = robotnix.lib.robotnixSystem (
        { config, pkgs, ... }:
        {
          device = "lemonades";
          flavor = "lineageos";
          androidVersion = 11;

          apps.chromium.enable = false;
          webview.chromium.enable = false;

          source.dirs."device/oneplus/lemonades".src = pkgs.fetchFromGitHub {
            owner = "wegank";
            repo = "android_device_oneplus_lemonades";
            rev = "7e5f3ab81051d7598959f89267afaf57bfdd5901";
            sha256 = "sha256-ejM9JRTSDYCVlLKs/46SxS4LYqi66Kx+2yTTehQw4t4=";
          };

          source.dirs."kernel/oneplus/sm8250".src = pkgs.fetchFromGitHub {
            owner = "wegank";
            repo = "android_kernel_oneplus_sm8250";
            rev = "da96fc8381685b615f045014b7e1175494c1cd2d";
            sha256 = "sha256-fVptlGq9Ng1Uv5EQl+m2taIPPDqkiwT9lxo3EUweqTE=";
          };

          source.dirs."hardware/oneplus".src = pkgs.fetchFromGitHub {
            owner = "LineageOS";
            repo = "android_hardware_oneplus";
            rev = "3e3340698870b9a73ed1b7632a08f3a2d443f3b3";
            sha256 = "sha256-4t9gr7ktlF03WJ7DyMp8p9zH2jKO1wz9Z1Qth5dqang=";
          };

          source.dirs."vendor/oneplus".src = pkgs.fetchFromGitHub {
            owner = "wegank";
            repo = "proprietary_vendor_oneplus";
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
        }
      );

      defaultPackage.aarch64-linux = self.robotnixConfigurations."lemonades".img;
    };
}
