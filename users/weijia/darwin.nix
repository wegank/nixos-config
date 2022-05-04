{ pkgs, ... }:

{
  imports = [
    ./app/texlive.nix
  ];

  home.packages = with pkgs; [
    neofetch
    /*
      (pkgs.callPackage ./dev/codeblocks/default.nix {
      contribPlugins = true;
      })
    */
  ];
}
