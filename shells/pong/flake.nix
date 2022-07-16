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
                  "0x321b3326ab24bA74a52e038327Adc42264C3093e"
                  "0x41D60D3271ab0da8640040B4599737A5A31fD6db"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
