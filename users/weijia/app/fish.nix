{ lib, isDarwin, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
    '' + lib.optionalString isDarwin ''
      fish_add_path --path --move /run/current-system/sw/bin
      fish_add_path $HOME/.npm-global/bin
      fish_add_path $HOME/.cargo/bin
      fish_add_path $HOME/.juliaup/bin
    '';
  };
}
