{
  lib,
  pkgs,
  isLinux,
  ...
}:

{
  fonts =
    {
      packages =
        with pkgs;
        [
          powerline-fonts
          source-code-pro
        ]
        ++ lib.optionals isLinux [
          cantarell-fonts
          font-awesome
          hack-font
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-emoji
          noto-fonts-extra
        ];
    }
    // lib.optionalAttrs isLinux {
      fontDir = {
        enable = true;
      };
    };
}
