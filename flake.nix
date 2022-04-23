{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }:
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
        (builtins.replaceStrings [" " "-"] ["" ""] (strings.toLower name));
    in
    {
      # macOS configurations.
      homeConfigurations = builtins.mapAttrs
        (hostname: host:
          home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = {
              owner = metadata.owner;
              inherit host;
            };
            configuration =
              import (./users + "/${metadata.owner.name}" + /home.nix);
            system = host.platform;
            homeDirectory = "/Users/${parseName metadata.owner.fullName}";
            username = parseName metadata.owner.fullName;
            stateVersion = "21.11";
          }
        )
        (filterMachines "darwin");
      
      # NixOS configurations.
      nixosConfigurations = builtins.mapAttrs
        (hostname: host:
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
              (./system + "/${host.profile}.nix")
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
