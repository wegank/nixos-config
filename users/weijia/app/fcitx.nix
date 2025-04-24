{ pkgs, ... }:

{
  i18n = {
    inputMethod = {
      enable = true;
      # Enable Fcitx.
      type = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    };
  };
}
