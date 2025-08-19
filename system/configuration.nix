# System configuration.

{
  lib,
  isDarwin,
  isLinux,
  ...
}:

{
  imports = [
    ./app/fish.nix
    ./app/virt-manager.nix
    ./app/vscode.nix
    ./dev/android-tools.nix
    ./dev/postgresql.nix
    ./media/font.nix
    ./sys/nix.nix
    ./x11/xorg-server.nix
  ]
  ++ lib.optionals isDarwin [
    ./darwin.nix
  ]
  ++ lib.optionals isLinux [
    ./linux.nix
  ];
}
