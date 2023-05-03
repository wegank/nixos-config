{ pkgs, ... }:

{
  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      cachix
      nixpkgs-fmt
      (nixpkgs-review.overrideAttrs (old: {
        patches = [
          (fetchpatch {
            name = "fix-detection-of-broken-packages.patch";
            url = "https://github.com/Mic92/nixpkgs-review/commit/1e67afb01e3a16bba617c3bb14752797c730a450.patch";
            hash = "sha256-71pbcg+nFRUZZxpPKH93EFzyrAG3wVWMaCVIvgLaTH0=";
          })
        ];
      }))
      rnix-lsp
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
