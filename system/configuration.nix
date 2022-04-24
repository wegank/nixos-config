# System configuration.

{ lib, isDarwin, isLinux, ... }:

{
  imports = [
    ./app/zsh.nix
    ./dev/postgresql.nix
    ./media/font.nix
    ./sys/nix.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
