{ lib, pkgs, isDarwin, isLinux, isServer, ... }:

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
        "https://cache.weijia.wang/"
      ];
      trusted-public-keys = [
        "cache.weijia.wang:2aRaA9TLlndTMKhIgKDdiHiy4JCEYR+N9011PU1VxNo="
      ];
    };
  };

  services = lib.optionalAttrs isDarwin {
    nix-daemon.enable = true;
  };
}
