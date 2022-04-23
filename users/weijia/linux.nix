{ pkgs, lib, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
in
{
  imports = [
    ./gui/gtk.nix
    ./x11/xdg.nix
  ] ++ lib.optionals isDesktop [
    ./app/fcitx.nix
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
