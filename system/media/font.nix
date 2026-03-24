{
  lib,
  pkgs,
  isLinux,
  ...
}:

{
  fonts = {
    packages =
      with pkgs;
      [
        powerline-fonts
        source-code-pro
      ]
      ++ lib.optionals isLinux [
        adwaita-fonts
        font-awesome
        hack-font
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];
  }
  // lib.optionalAttrs isLinux {
    fontDir = {
      enable = true;
    };
  };
}
