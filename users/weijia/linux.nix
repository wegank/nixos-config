{
  lib,
  pkgs,
  isDesktop,
  ...
}:

{
  imports =
    [
      ./dev/qt.nix
      ./x11/gtk.nix
      ./x11/xdg.nix
      ./www/chromium.nix
    ]
    ++ lib.optionals isDesktop [
      ./app/fcitx.nix
      ./app/texlive.nix
      ./gnome/dconf.nix
      ./gui/sway.nix
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
