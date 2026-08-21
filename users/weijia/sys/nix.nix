{
  config,
  pkgs,
  ...
}:

{
  nix.buildMachines = [ ];

  nix.distributedBuilds = true;

  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      nil
      nixd
      nixfmt
      nixpkgs-review
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
