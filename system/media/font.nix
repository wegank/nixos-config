{ pkgs, lib, host, ... }:

let
  isLinux = lib.hasSuffix "linux" host.platform;
in
{
  fonts = {
    fontDir = {
      enable = true;
    };
    fonts = with pkgs; [
      powerline-fonts
    ] ++ lib.optionals isLinux [
      cantarell-fonts
      font-awesome
      hack-font
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };
}
