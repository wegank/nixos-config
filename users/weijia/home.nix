# Home configuration.

{ lib, isDarwin, isLinux, isMobile, ... }:

{
  imports = [
    ./app/fish.nix
    ./dev/git.nix
    ./sys/nix.nix
  ] ++ lib.optionals (!isMobile) [
    ./app/alacritty.nix
    ./app/vscodium.nix
    # ./net/nodejs.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];

  home.stateVersion = "22.05";
}
