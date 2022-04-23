# Home configuration.

{ pkgs, lib, owner, host, ... }:

let
  isDarwin = lib.hasSuffix "darwin" host.platform;
  isLinux = lib.hasSuffix "linux" host.platform;
in
{
  imports = [
    ./app/alacritty.nix
    ./app/vscodium.nix
    ./app/zsh.nix
    ./dev/git.nix
    ./sys/nix.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
