{ config, pkgs, owner, ... }:

{
  services.xserver = {
    desktopManager = {
      gnome.enable = true;
    };
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = owner.name;
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
