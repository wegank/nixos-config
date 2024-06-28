{
  lib,
  isDarwin,
  isLinux,
  ...
}:

{
}
// lib.optionalAttrs isDarwin { homebrew.casks = [ "docker" ]; }
// lib.optionalAttrs isLinux {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
