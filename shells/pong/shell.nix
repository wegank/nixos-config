{ pkgs ? import <nixpkgs> {
    overlays = [ (import ../../../nur-packages/overlay.nix) ];
  }
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    (perpetual-pools-client.override {
      pongified = true;
      pools = [
        "0x2b6314479002ED5104F391989d4F761f71231b54"
        "0xaB1510e740F0c9247974e61d900eC964337d5D5A"
        "0x4Fd513f353Bc834aBd7Df5e054E35eC40812af30"
        "0xCb92788f7736f87f4a53fFcbb4B2AF70A65346ba"
      ];
    })
    perpetual-pools-keeper
  ];
}
