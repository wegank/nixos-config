{
  lib,
  pkgs,
  owner,
  isDarwin,
  isLinux,
  isMobile,
  isServer,
  ...
}:

{
  nix =
    {
      enable = true;
      package = pkgs.nixVersions.nix_2_30;
      gc = {
        automatic = !isDarwin && !isServer;
        options = "--delete-older-than 30d";
      };
      extraOptions = ''
        experimental-features = nix-command flakes
        min-free = ${toString (100 * 1024 * 1024)}
        max-free = ${toString (1024 * 1024 * 1024)}
      '';
    }
    // lib.optionalAttrs isLinux {
      gc.dates = "weekly";
      settings = {
        auto-optimise-store = !isServer;
        substituters = [
          "https://wegank.cachix.org/"
        ] ++ lib.optionals isMobile [ "https://cache.weijia.wang/" ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "wegank.cachix.org-1:xHignps7GtkPP/gYK5LvA/6UFyz98+sgaxBSy7qK0Vs="
          "cache.weijia.wang:eoqjYwQwXrRbuIpOjGG+pfMk5jD6BkjUoTHaSZE6pLU="
        ];
        trusted-users = [ owner.name ];
      };
    };
}
