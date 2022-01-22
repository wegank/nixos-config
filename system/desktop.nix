{ config, pkgs, ... }:

{
  services.xserver = {
    desktopManager = {
      gnome.enable = true;
    };
    displayManager.defaultSession = "sway";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ ];
  };
}
