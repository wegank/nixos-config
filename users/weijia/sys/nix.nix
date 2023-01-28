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
      nixpkgs-fmt
      nixpkgs-review
      rnix-lsp
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
