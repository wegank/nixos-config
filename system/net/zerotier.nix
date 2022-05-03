{ lib, isDarwin, isLinux, ... }:

{ } // lib.optionalAttrs isDarwin {
  homebrew.casks = [
    "zerotier-one"
  ];
} // lib.optionalAttrs isLinux {
  services.zerotierone = {
    enable = true;
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [
      "zerotierone"
    ];
}
