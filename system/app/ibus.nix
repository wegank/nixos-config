{
  pkgs,
  ...
}:

{
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      hangul
      mozc
      rime
    ];
  };
}
