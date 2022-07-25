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
                  "0xE4fBa2EFA9d51a787eb2ff7d2676050A1A4a9E6B"
                  "0x979A02ABC308297902733B61F693EA957bC8a46F"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
