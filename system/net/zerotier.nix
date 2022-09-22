{ lib, pkgs, isDarwin, isLinux, ... }:

{ } // lib.optionalAttrs isDarwin {
  homebrew.casks = [
    "zerotier-one"
  ];
} // lib.optionalAttrs isLinux {
  services.zerotierone = {
    enable = true;
    package = with pkgs; zerotierone.overrideAttrs (old: {
      cargoDeps = rustPlatform.importCargoLock {
        lockFile = fetchurl {
          url = "https://raw.githubusercontent.com/zerotier/ZeroTierOne/${old.version}/zeroidc/Cargo.lock";
          sha256 = "sha256-pn7t7udZ8A72WC9svaIrmqXMBiU2meFIXv/GRDPYloc=";
        };
        outputHashes = {
          "jwt-0.16.0" = "sha256-P5aJnNlcLe9sBtXZzfqHdRvxNfm6DPBcfcKOVeLZxcM=";
        };
      };
    });
  };

  environment.unfreePackages = [
    "zerotierone"
  ];
}
