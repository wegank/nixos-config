{ pkgs, ... }:

let
  vscode_1_82 = pkgs.fetchpatch {
    url = "https://github.com/nix-community/nixos-vscode-server/pull/68.patch";
    hash = "sha256-kZWOcw3QKZK598nWj9UuMCJlQxQ/qzBKqACkQO8+jvI=";
  };
in
{
  services = {
    vscode-server = {
      enable = true;
      postPatch = ''
        patch -p1 < ${vscode_1_82}
      '';
    };
  };
}
