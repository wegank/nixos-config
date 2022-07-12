{ lib, pkgs, isDarwin, isLinux, isMobile, isServer, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = !isDarwin && !isServer;
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  } // lib.optionalAttrs isLinux {
    gc.dates = "weekly";
    settings = {
      auto-optimise-store = !isServer;
      substituters = [
        "https://wegank.cachix.org/"
      ] ++ lib.optionals isMobile [
        "https://cache.weijia.wang/"
      ];
      trusted-public-keys = [
        "wegank.cachix.org-1:xHignps7GtkPP/gYK5LvA/6UFyz98+sgaxBSy7qK0Vs="
        "cache.weijia.wang:2aRaA9TLlndTMKhIgKDdiHiy4JCEYR+N9011PU1VxNo="
      ];
    };
  };

  services = lib.optionalAttrs isDarwin {
    nix-daemon.enable = true;
  };
}
