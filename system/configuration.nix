# System configuration.

{ lib, isDarwin, isLinux, isMobile, ... }:

{
  imports = [
    ./app/vscode.nix
    ./app/zsh.nix
    ./media/font.nix
    ./sys/nix.nix
    ./x11/xorg-server.nix
  ] ++ lib.optionals (!isMobile) [
    ./dev/postgresql.nix
    ./net/zerotier.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
