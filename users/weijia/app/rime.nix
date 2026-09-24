{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."ibus/rime/default.custom.yaml" = {
    source = (pkgs.formats.yaml { }).generate "default.custom.yaml" {
      patch.schema_list = [
        { schema = "double_pinyin_mspy"; }
      ];
    };
    onChange = ''
      rm -rf "${config.xdg.configHome}/ibus/rime/build"
    '';
  };
}
