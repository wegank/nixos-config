{ lib, pkgs, isDarwin, isLinux, ... }:

{ } // lib.optionalAttrs isDarwin {
  homebrew.casks = [
    "zerotier-one"
  ];
} // lib.optionalAttrs isLinux {
  services.zerotierone = {
    enable = true;
  };

  environment.unfreePackages = [
    "zerotierone"
  ];
}
