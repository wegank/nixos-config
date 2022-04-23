{ lib, ... }:

{
  services = {
    zerotierone = {
      enable = true;
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [
      "zerotierone"
    ];
}
