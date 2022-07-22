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
                  "0x483e6De23a12946ce5157B0358662212313f6E02"
                  "0xE3BD6De03dfa1fD8E1901cB098d2ffE64AB06Dc6"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
