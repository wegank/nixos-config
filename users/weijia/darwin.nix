{ pkgs, ... }:

{
  imports = [ ./app/texlive.nix ];

  home.packages = with pkgs; [
    fastfetch
    rectangle
    utm
  ];
}
