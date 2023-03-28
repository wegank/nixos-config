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

  # https://github.com/NixOS/nixpkgs/issues/223458
  hardware.opengl.mesaPackage = pkgs.mesa;
}
