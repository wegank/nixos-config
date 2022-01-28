{
  description = "Build LineageOS for OnePlus 9R";

  inputs.robotnix.url = "github:danielfullmer/robotnix";

  outputs = { self, robotnix }: {
    robotnixConfigurations."oneplus9r" = robotnix.lib.robotnixSystem ({ config, pkgs, ... }: {
      device = "oneplus9r";
      flavor = "lineageos";
      androidVersion = 11;

      apps.chromium.enable = false;
      webview.chromium.enable = false;

      source.dirs."device/oneplus/oneplus9r".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "device_oneplus_oneplus9r";
        rev = "e5488d45daa0f7b2c4f2abb720b26af548824914";
        sha256 = "sha256-LNauR62SbjvpCOBzW8tIlTDo7mnJMx6lt86Ihd24Q7o=";
      };

      source.dirs."kernel/oneplus/sm8250".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "kernel_oneplus_sm8250";
        rev = "e738058736bc87219414767c443b9b77dc611990";
        sha256 = "sha256-ULi+9XF6HMuHHRmQwZ0liJhLzLe9VM2bWXzTBn7nwNw=";
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
        rev = "9100879f5dbc555e45dca35040289eee44a1afcd";
        sha256 = "sha256-fyCC/RQ7E9wYxbXQd5WtsKanh8deNOnfNqEYWLCG2JI=";
      };

      ccache.enable = true;
    });

    defaultPackage.aarch64-linux = self.robotnixConfigurations."oneplus9r".img;
  };
}
