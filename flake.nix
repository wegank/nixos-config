{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }: {
    nixosConfigurations = builtins.mapAttrs
      (hostname: _:
        let configs = {
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
        }; in
        nixpkgs.lib.nixosSystem {
          system = configs.${hostname}.platform;
          modules = [
            # Hardware configuration.
            (./hardware + "/${hostname}" + /hardware-configuration.nix)
            # System configuration.
            ./system/base.nix
            (./system + "/${configs.${hostname}.profile}.nix")
            # Home Manager.
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = {
                  profile = configs.${hostname}.profile;
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
