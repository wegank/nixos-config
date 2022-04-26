{ lib, pkgs, isDarwin, ... }:

{
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_14;
      enableTCPIP = true;
    } // lib.optionalAttrs isDarwin {
      dataDir = "/usr/local/var/postgres";
    };
  };
}
