{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }: {
    nixosConfigurations = builtins.mapAttrs
      (hostname: _:
        nixpkgs.lib.nixosSystem {
          system = {
            parallels = "aarch64-linux";
            parallels-unfree = "aarch64-linux";
            raspberrypi = "aarch64-linux";
            vmware = "x86_64-linux";
          }.${hostname};
          modules = [
            # Hardware configuration.
            (./hardware + "/${hostname}" + /hardware-configuration.nix)
            # System configuration.
            ./system/common.nix
            (if hostname == "raspberrypi" then
              ./system/server.nix
            else
              ./system/desktop.nix)
            # Home Manager.
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
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
