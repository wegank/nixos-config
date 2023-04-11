{ lib, pkgs, isDarwin, isLinux, ... }:

{ } // lib.optionalAttrs isDarwin {
  homebrew.casks = [
    "xquartz"
  ];
} // lib.optionalAttrs isLinux {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    excludePackages = with pkgs; [
      xterm
    ];
  };
}
