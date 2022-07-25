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
                  "0x5855Ad0f0faebc646244400601e674C84182C474"
                  "0x2f3A27B4fD53464F51f6A16d647413E353e940a7"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
