# System configuration.

{ config, lib, pkgs, owner, host, ... }:

let
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  imports = [
    ./sys/nix.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
