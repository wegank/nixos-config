{ pkgs, ... }:

{
  imports = [
    ./app/texlive.nix
  ];

  home.packages = with pkgs; [
    # neofetch
  ];
}
