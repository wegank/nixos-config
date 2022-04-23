# System configuration.

{ config, lib, pkgs, owner, host, ... }:

let
  isDarwin = lib.strings.hasSuffix "darwin" host.platform;
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  imports = [
    ./media/font.nix
    ./sys/nix.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
