{ pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;
      promptInit = "";
    };
  };

  environment.shells = [
    pkgs.fish
  ];
}
