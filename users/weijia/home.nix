# Home configuration.

{ pkgs, lib, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  imports = [
    ./app/alacritty.nix
    ./app/texlive.nix
    ./app/zsh.nix
    ./dev/git.nix
  ] ++ lib.optionals isLinux [
    ./app/fcitx.nix
    ./gui/gtk.nix
    ./x11/xdg.nix
  ] ++ lib.optionals isDesktop [
    ./app/vscodium.nix
  ] ++ lib.optionals (isDesktop && isLinux) [
    ./gui/sway.nix
    ./www/chromium.nix
    ./www/firefox.nix
  ];

  manual = {
    manpages = {
      enable = false;
    };
  };

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

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
