{ config, lib, ... }:

with lib;

{
  options = {
    environment.unfreePackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg)
        config.environment.unfreePackages;
  };
}
