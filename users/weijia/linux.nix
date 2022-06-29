{ lib, pkgs, isDesktop, ... }:

{
  imports = [
    ./dev/qt.nix
    ./x11/gtk.nix
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
      neofetch
      screen
      tmux
    ];
  };
}
