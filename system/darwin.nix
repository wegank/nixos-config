{ lib, pkgs, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
in
{
  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "vscode-extension-github-copilot"
    "vscode-extension-MS-python-vscode-pylance"
  ];

  # Set state version.
  system.stateVersion = 4;
}
