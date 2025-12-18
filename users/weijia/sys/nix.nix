{
  config,
  pkgs,
  ...
}:

{
  nix.buildMachines = [
    ({
      hostName = "120.202.241.46:32203";
      sshKey = "${config.home.homeDirectory}/.ssh/id_ed25519";
      sshUser = "wegank";
      supportedFeatures = [
        "big-parallel"
        "gccarch-la64v1.0"
      ];
      systems = [ "loongarch64-linux" ];
    })
  ];

  nix.distributedBuilds = true;

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
