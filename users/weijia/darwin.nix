{ pkgs, ... }:

{
  imports = [ ./app/texlive.nix ];

  home.packages = with pkgs; [
    fastfetch
    poetry
    rectangle
    utm
  ];
}
