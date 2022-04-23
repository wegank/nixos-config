{ pkgs, lib, owner, host, ... }:

{
  imports = [
    ./app/texlive.nix
  ];

  home.packages = with pkgs; [
    neofetch
  ];
}
