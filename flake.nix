{
  description = "NixOS configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mobile-nixos = {
      url = "github:nixos/mobile-nixos";
      flake = false;
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, mobile-nixos, nixpkgs, nix-darwin }:
    let
      metadata = builtins.fromTOML (builtins.readFile ./flake.toml);
      owner = metadata.users.${metadata.owner.name};

      lib = nixpkgs.lib;

      # Filter machines by suffix.
      filterMachines = suffix:
        (lib.filterAttrs
          (_: config: lib.hasSuffix suffix config.platform)
          metadata.machines);

      # Get username.
      getUserName = name: host:
        let fullName = lib.splitString " "
          (lib.toLower metadata.users.${name}.fullName); in
        if (lib.hasSuffix "darwin" host.platform) then
          lib.concatStrings fullName
        else
          lib.head fullName;

      # Set special args.
      setSpecialArgs = host: {
        inherit owner;
        isDarwin = lib.hasSuffix "darwin" host.platform;
        isLinux = lib.hasSuffix "linux" host.platform;
        isDesktop = (host.profile == "desktop");
        isMobile = (host.profile == "mobile");
        isServer = (host.profile == "server");
      };

      # Set Home Manager template.
      setHomeManagerTemplate = host: {
        home-manager = {
          useUserPackages = true;
          useGlobalPkgs = true;
          extraSpecialArgs = setSpecialArgs host;
          users = lib.mapAttrs'
            (name: _:
              lib.nameValuePair
                (getUserName name host)
                (./users + "/${name}" + /home.nix))
            metadata.users;
        };
      };
    in
    {
      # macOS configurations.
      darwinConfigurations = builtins.mapAttrs
        (hostname: host:
          nix-darwin.lib.darwinSystem {
            system = host.platform;
            specialArgs = setSpecialArgs host;
            modules = [
              # Nix Modules.
              ./modules/environment.nix
              # System configuration.
              ./system/configuration.nix
              # Home Manager configuration.
              home-manager.darwinModules.home-manager
              (setHomeManagerTemplate host)
            ];
          }
        )
        (filterMachines "darwin");

      # NixOS configurations.
      nixosConfigurations = builtins.mapAttrs
        (hostname: host:
          nixpkgs.lib.nixosSystem {
            system = host.platform;
            specialArgs = setSpecialArgs host;
            modules = [
              # Nix Modules.
              ./modules/environment.nix
              # Hardware configuration.
              (
                if hostname == "pinephone" then
                  (import "${mobile-nixos}/lib/configuration.nix" {
                    device = "pine64-pinephone";
                  })
                else
                  ./hardware + "/${hostname}" + /hardware-configuration.nix
              )
              # System configuration.
              ./system/configuration.nix
              # Home Manager configuration.
              home-manager.nixosModules.home-manager
              (setHomeManagerTemplate host)
            ];
          }
        )
        (filterMachines "linux");
    };
}
