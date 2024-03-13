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
      nixfmt-rfc-style
      nixpkgs-review
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
