{ pkgs ? import <nixpkgs> {
    overlays = [ (import ../../../nur-packages/overlay.nix) ];
  }
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    (perpetual-pools-client.override {
      pongified = true;
      pools = [
        "0xc08F53bd2787Bfb6057FDc60c3405E41274E8d8C"
        "0xDb7ade08134f7D4a992AdA5B7c07Cb3314dFD0c4"
        "0x51dd1e0260A4a0157C4D242fE05cE0141B07B2b4"
      ];
    })
    perpetual-pools-keeper
  ];
}
