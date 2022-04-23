# System configuration.

{ config, lib, pkgs, owner, host, ... }:

let
  isDarwin = lib.hasSuffix "darwin" host.platform;
  isLinux = lib.hasSuffix "linux" host.platform;
in
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
