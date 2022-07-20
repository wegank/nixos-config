{
  description = "A flake for building Pong";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nur-packages = {
      url = github:wegank/nur-packages;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur-packages }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      defaultPackage = forAllSystems
        (system:
          let
            pkgs = import nixpkgs { inherit system; };
            nur-pkgs = import nur-packages { inherit pkgs; };
          in
          pkgs.mkShell {
            nativeBuildInputs = with nur-pkgs; [
              (perpetual-pools-client.override {
                pongified = true;
                pools = [
                  "0x12cDaC90Bd8F1b661E5193B9425EAa4dC1f422b7"
                  "0x96C8b6A8D99f94F196bdC3F6d8747C6CC42a1F23"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
