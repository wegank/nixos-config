{
  lib,
  pkgs,
  isDarwin,
  ...
}:

{
  programs.emacs = {
    enable = true;
    package =
      if isDarwin then
        pkgs.emacs30.override {
          withMailutils = false;
        }
      else
        pkgs.emacs30;
    extraConfig = lib.optionalString isDarwin ''
      (setq mac-right-option-modifier 'nil)
    '';
  };
}
