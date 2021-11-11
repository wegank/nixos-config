{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }: {
    nixosConfigurations = builtins.mapAttrs ( hostname: _: 
      nixpkgs.lib.nixosSystem {
        system = {
          parallels = "aarch64-linux";
          vmware = "x86_64-linux";
        }.${hostname};
        modules = [
          # Hardware configuration.
          (./hardware + "/${hostname}" + /hardware-configuration.nix)
          # System configuration.
          ./system/configuration.nix
          # Home Manager.
          home-manager.nixosModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.weijia = import ./user/home.nix;
            };
          }
        ];
      }
    ) (builtins.readDir ./hardware);
  };
}
