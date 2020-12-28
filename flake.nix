{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = 
      "github:nix-community/home-manager/release-20.09";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  };

  outputs = { self, home-manager, nixpkgs }: {
    nixosConfigurations = {
      parallels = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/parallels.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.weijia = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
