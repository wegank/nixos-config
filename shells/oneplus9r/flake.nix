{
  description = "Build LineageOS for OnePlus 9R";

  inputs.robotnix.url = "github:danielfullmer/robotnix";

  outputs = { self, robotnix }: {
    robotnixConfigurations."oneplus9r" = robotnix.lib.robotnixSystem ({ config, pkgs, ... }: {
      device = "oneplus9r";
      flavor = "lineageos";

      source.dirs."device/oneplus/oneplus9r".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "device_oneplus_oneplus9r";
        rev = "e5488d45daa0f7b2c4f2abb720b26af548824914";
        sha256 = "";
      };

      source.dirs."kernel/oneplus/sm8250".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "kernel_oneplus_sm8250";
        rev = "e738058736bc87219414767c443b9b77dc611990";
        sha256 = "";
      };

      source.dirs."vendor/oneplus".src = pkgs.fetchFromGitHub {
        owner = "YumeMichi";
        repo = "proprietary_vendor_oneplus";
        rev = "9100879f5dbc555e45dca35040289eee44a1afcd";
        sha256 = "";
      };

      ccache.enable = true;
    });
    
    defaultPackage.x86_64-linux = self.robotnixConfigurations."oneplus9r".img;
  };
}
