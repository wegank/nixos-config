# Home configuration.

{ pkgs, lib, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  imports = [
    ./app/alacritty.nix
    ./app/zsh.nix
    ./dev/git.nix
    ./sys/nix.nix
  ] ++ lib.optionals isLinux [
    ./gui/gtk.nix
    ./x11/xdg.nix
  ] ++ lib.optionals isDesktop [
    ./app/vscodium.nix
  ] ++ lib.optionals (isDesktop && isLinux) [
    ./app/fcitx.nix
    ./gui/sway.nix
    ./www/chromium.nix
    ./www/firefox.nix
  ] ++ lib.optionals (isDesktop && !isLinux) [
    ./app/texlive.nix
  ];

  home = {
    packages = with pkgs; [
      # Userland.
      # android-tools
      neofetch
      screen
      # Custom.
      # (pkgs.callPackage ./aegisub/default.nix { })
    ];
  };
}
