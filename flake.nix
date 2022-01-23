{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }:
    let
      owner = {
        name = "weijia";
        description = "Weijia Wang";
        initialPassword = "changeme";
      };
      machines = {
        parallels = {
          platform = "aarch64-linux";
          profile = "desktop";
        };
        parallels-unfree = {
          platform = "aarch64-linux";
          profile = "desktop";
        };
        raspberrypi = {
          platform = "aarch64-linux";
          profile = "server";
        };
        vmware = {
          platform = "x86_64-linux";
          profile = "desktop";
        };
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (hostname: _:
          nixpkgs.lib.nixosSystem {
            system = machines.${hostname}.platform;
            specialArgs = {
              owner = owner;
            };
            modules = [
              # Hardware configuration.
              (./hardware + "/${hostname}" + /hardware-configuration.nix)
              # System configuration.
              ./system/base.nix
              (./system + "/${machines.${hostname}.profile}.nix")
              # Home Manager.
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useUserPackages = true;
                  useGlobalPkgs = true;
                  extraSpecialArgs = {
                    profile = machines.${hostname}.profile;
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
        (builtins.readDir ./hardware);
    };
}
