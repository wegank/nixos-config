{
  lib,
  pkgs,
  isDarwin,
  isLinux,
  ...
}:

{
  services = {
    postgresql =
      {
        enable = true;
        package = pkgs.postgresql_14;
        enableTCPIP = true;
      }
      // lib.optionalAttrs isDarwin {
        # https://github.com/LnL7/nix-darwin/issues/339
        dataDir = "/usr/local/var/postgres";
      }
      // lib.optionalAttrs isLinux {
        authentication = pkgs.lib.mkOverride 10 ''
          local all all trust
          host all all 127.0.0.1/32 trust
          host all all ::1/128 trust
        '';
      };
  };
}
