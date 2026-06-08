{
  lib,
  pkgs,
  isDarwin,
  ...
}:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs31;
    extraConfig = lib.optionalString isDarwin ''
      (setq mac-right-option-modifier 'nil)
    '';
  };
}
