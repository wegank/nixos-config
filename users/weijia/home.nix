# Home configuration.

{ lib, isDarwin, isLinux, ... }:

{
  imports = [
    ./app/alacritty.nix
    ./app/vscodium.nix
    ./app/zsh.nix
    ./dev/android-tools.nix
    ./dev/git.nix
    ./sys/nix.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
