{
  lib,
  pkgs,
  isDarwin,
  isLinux,
  ...
}:

lib.optionalAttrs isDarwin { homebrew.casks = [ "xquartz" ]; }
// lib.optionalAttrs isLinux {
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
  };

  services.libinput = {
    enable = true;
  };
}
