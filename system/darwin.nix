{ lib, pkgs, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
in
{
  imports = [
    ./sys/brew.nix
  ];

  # Set state version.
  system.stateVersion = 4;
}
