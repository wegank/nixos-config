{ pkgs, ... }:

{
  imports = [ ./app/texlive.nix ];

  home.packages = with pkgs; [
    fastfetch
    msolve
    poetry
    rectangle
    utm
  ];
}
