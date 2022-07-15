{
  description = "A flake for building Pong";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nur-packages.url = github:wegank/nur-packages;
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
                  "0xBDF07af974352276b951C77cDCC51165FbC2bD6e"
                  "0xf7edd0b21b260FD888CbBb8c2C524824e0b3ebfC"
                  "0xeF698d6a9fa7A5Dba62B71cDc5811b5FECC505f3"
                  "0xA4aF2845064116f338310b722c494D2aD092bD93"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
