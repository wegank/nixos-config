{
  lib,
  pkgs,
  isDarwin,
  ...
}:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30.override {
      withNativeCompilation = !isDarwin;
    };
    extraConfig = lib.optionalString isDarwin ''
      (setq mac-right-option-modifier 'nil)
    '';
  };
}
