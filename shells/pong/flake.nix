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
                  "0xb6F1394926d28379473E566d43f728F8B5f49A09"
                  "0xBE1E633533724916Ad1E92656b380294587C056D"
                  "0xb754a52D55C4193b87932bFaf96a1822FA13Be6A"
                  "0xaF989457d39c2D7D118373773571AFe1224C11D4"
                ];
              })
              perpetual-pools-keeper
            ];
          }
        );
    };
}
