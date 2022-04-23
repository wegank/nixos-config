{ config, pkgs, owner, ... }:

{
  imports = [
    ./gui/sway.nix
    ./gnome/gdm.nix
    ./gnome/gnome.nix
  ];
}
