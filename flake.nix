{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }:
    let
      metadata = builtins.fromTOML (builtins.readFile ./flake.toml);
      filterMachines = suffix:
        (nixpkgs.lib.attrsets.filterAttrs
          (_: config: nixpkgs.lib.strings.hasSuffix "linux" config.platform)
          metadata.machines);
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (hostname: _:
          nixpkgs.lib.nixosSystem {
            system = metadata.machines.${hostname}.platform;
            specialArgs = {
              owner = metadata.owner;
            };
            modules = [
              # Hardware configuration.
              (./hardware + "/${hostname}" + /hardware-configuration.nix)
              # System configuration.
              ./system/base.nix
              (./system + "/${metadata.machines.${hostname}.profile}.nix")
              # Home Manager.
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useUserPackages = true;
                  useGlobalPkgs = true;
                  extraSpecialArgs = {
                    owner = metadata.owner;
                    host = metadata.machines.${hostname};
                  };
                  users = builtins.mapAttrs
                    (username: _:
                      ./users + "/${username}" + /home.nix
                    )
                    (builtins.readDir ./users);
                };
              }
            ];
          }
        )
        (filterMachines "linux");
    };
}
