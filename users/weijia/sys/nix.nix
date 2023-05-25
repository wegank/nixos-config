{ pkgs, ... }:

{
  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      cachix
      nil
      nixpkgs-fmt
      nixpkgs-review
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
