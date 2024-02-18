# Home configuration.

{ lib, isDarwin, isLinux, isMobile, ... }:

{
  imports = [
    ./app/emacs.nix
    ./app/fish.nix
    ./app/neovim.nix
    ./dev/git.nix
    ./sys/nix.nix
  ] ++ lib.optionals (!isMobile) [
    ./app/alacritty.nix
    ./app/vscode.nix
    # ./net/nodejs.nix
  ] ++ lib.optionals isDarwin [
    ./darwin.nix
  ] ++ lib.optionals isLinux [
    ./linux.nix
  ];

  home.stateVersion = "22.05";
}
