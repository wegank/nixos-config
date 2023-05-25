# System configuration.

{ lib, isDarwin, isLinux, isMobile, ... }:

{
  imports = [
    ./app/vscode.nix
    ./app/fish.nix
    ./dev/android-tools.nix
    ./media/font.nix
    ./sys/nix.nix
    ./x11/xorg-server.nix
  ] ++ lib.optionals (!isMobile) [
    ./app/podman.nix
    ./app/virt-manager.nix
    ./dev/postgresql.nix
    ./net/zerotier.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
