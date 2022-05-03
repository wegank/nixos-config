# System configuration.

{ lib, isDarwin, isLinux, ... }:

{
  imports = [
    ./app/zsh.nix
    ./dev/postgresql.nix
    ./media/font.nix
    ./net/zerotier.nix
    ./sys/nix.nix
    ./x11/xorg-server.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
