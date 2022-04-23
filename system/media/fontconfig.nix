{ pkgs, ... }:

{
  console = {
    font = "Lat2-Terminus16";
  };

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [
        "Cantarell"
        "Noto Sans CJK SC"
        "Noto Sans CJK TC"
        "Noto Sans CJK JP"
      ];
    };
  };

  fonts.fonts = with pkgs; [
    font-awesome
    cantarell-fonts
    hack-font
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    powerline-fonts
  ];
}
