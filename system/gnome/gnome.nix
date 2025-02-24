{
  pkgs,
  ...
}:

{
  services = {
    xserver = {
      desktopManager = {
        gnome.enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    kimpanel
  ];
}
