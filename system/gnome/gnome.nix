{
  pkgs,
  ...
}:

{
  services.desktopManager.gnome = {
    enable = true;
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    kimpanel
  ];
}
