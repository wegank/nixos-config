{ lib, pkgs, isDarwin, isLinux, isServer, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = isLinux;
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  } // lib.optionalAttrs isLinux {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://cache.weijia.wang"
      ];
      trusted-public-keys = [
        "cache.weijia.wang:2aRaA9TLlndTMKhIgKDdiHiy4JCEYR+N9011PU1VxNo="
      ];
    } // lib.optionalAttrs (isLinux && !isServer) {
      settings.auto-optimise-store = true;
      gc.dates = "weekly";
    };
  };

  services = lib.optionalAttrs isDarwin {
    nix-daemon.enable = true;
  };
}
