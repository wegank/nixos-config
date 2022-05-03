{ lib, isDarwin, ... }:

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
  };
} // lib.optionalAttrs isDarwin {
  homebrew.casks = [
    "xquartz"
  ];
}
