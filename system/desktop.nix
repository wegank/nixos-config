{ config, pkgs, ... }:

{
  services.xserver = {
    desktopManager = {
      gnome.enable = true;
    };
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "weijia";
      };
      defaultSession = "sway";
    };
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ ];
  };
}
