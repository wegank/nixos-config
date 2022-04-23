{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin }:
    let
      attrsets = nixpkgs.lib.attrsets;
      strings = nixpkgs.lib.strings;
      metadata = builtins.fromTOML (builtins.readFile ./flake.toml);

      # Filter machines by suffix.
      filterMachines = suffix:
        (attrsets.filterAttrs
          (_: config: strings.hasSuffix suffix config.platform)
          metadata.machines);

      # Convert full name to username.
      parseName = name:
        (builtins.replaceStrings [ " " "-" ] [ "" "" ] (strings.toLower name));
    in
    {
      # macOS configurations.
      darwinConfigurations = builtins.mapAttrs
        (hostname: host:
          nix-darwin.lib.darwinSystem {
            system = host.platform;
            specialArgs = {
              owner = metadata.owner;
              inherit host;
            };
            modules = [
              # System configuration.
              ./system/configuration.nix
              # Home Manager.
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useUserPackages = true;
                  useGlobalPkgs = true;
                  extraSpecialArgs = {
                    owner = metadata.owner;
                    inherit host;
                  };
                  users.${parseName metadata.owner.fullName} = 
                    ./users + "/${metadata.owner.name}" + /home.nix;
                };
              }
            ];
          }
        )
        (filterMachines "darwin");

      # NixOS configurations.
      nixosConfigurations = builtins.mapAttrs
        (hostname: host:
          nixpkgs.lib.nixosSystem {
            system = host.platform;
            specialArgs = {
              owner = metadata.owner;
              inherit host;
            };
            modules = [
              # Hardware configuration.
              (./hardware + "/${hostname}" + /hardware-configuration.nix)
              # System configuration.
              ./system/configuration.nix
              # Home Manager.
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useUserPackages = true;
                  useGlobalPkgs = true;
                  extraSpecialArgs = {
                    owner = metadata.owner;
                    inherit host;
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
