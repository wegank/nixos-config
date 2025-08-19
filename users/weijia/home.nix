# Home configuration.

{
  lib,
  isDarwin,
  isLinux,
  stateVersion,
  ...
}:

{
  imports = [
    ./app/alacritty.nix
    ./app/emacs.nix
    ./app/fish.nix
    ./app/neovim.nix
    ./app/vscode.nix
    ./dev/git.nix
    ./net/openssh.nix
    ./sys/nix.nix
    # ./net/nodejs.nix
  ]
  ++ lib.optionals isDarwin [
    ./darwin.nix
  ]
  ++ lib.optionals isLinux [
    ./linux.nix
  ];

  home.stateVersion = stateVersion;
}
