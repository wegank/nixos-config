{ lib, pkgs, isDesktop, ... }:

{
  imports = [
    ./gui/gtk.nix
    ./x11/xdg.nix
  ] ++ lib.optionals isDesktop [
    ./app/fcitx.nix
    ./gnome/dconf.nix
    ./gui/sway.nix
    ./www/chromium.nix
    ./www/firefox.nix
  ];

  home = {
    packages = with pkgs; [
      # Userland.
      android-tools
      neofetch
      screen
      # Custom.
      # (pkgs.callPackage ./aegisub/default.nix { })
    ];
  };
}
