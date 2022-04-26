{ lib, pkgs, isDarwin, ... }:

{
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_14;
      enableTCPIP = true;
    } // lib.optionalAttrs isDarwin {
      # https://github.com/LnL7/nix-darwin/issues/339
      dataDir = "/usr/local/var/postgres";
    };
  };
}
