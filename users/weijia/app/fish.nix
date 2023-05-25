{ lib, isDarwin, ... }:

let
  darwinInit = ''
    fish_add_path --path --move $HOME/.local/bin $HOME/.nix-profile/bin /run/wrappers/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
    fish_add_path --path --move $HOME/.npm-global/bin
    fish_add_path --path --move $HOME/.cargo/bin
  '';
in
{
  programs = {
    fish = {
      enable = true;
      shellInit = lib.optionalString isDarwin darwinInit;
    };
  };
}
