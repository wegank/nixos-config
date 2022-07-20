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
                  "0xd460423F474321484825ee0edB5c6E8423c0761B"
                  "0x20315Ce32B89c5faf7f1dEb5eEaD2c8D49ca8157"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
