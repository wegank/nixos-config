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
      rnix-lsp
    ];
  };

  nix.settings = {
    sandbox = true;
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
