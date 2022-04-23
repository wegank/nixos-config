{ pkgs, ... }:

{
  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      nixpkgs-fmt
      rnix-lsp
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
