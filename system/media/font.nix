{ lib, pkgs, isLinux, ... }:

{
  fonts = {
    fontDir = {
      enable = true;
    };
    packages = with pkgs; [
      powerline-fonts
      source-code-pro
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
