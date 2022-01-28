{ config, lib, pkgs, ... }:

let unfreePackages = [
  "zerotierone"
]; in
{
  imports = [
    (fetchTarball {
      url = https://github.com/msteen/nixos-vscode-server/tarball/bc28cc2a7d866b32a8358c6ad61bea68a618a3f5;
      sha256 = "00aqwrr6bgvkz9bminval7waxjamb792c0bz894ap8ciqawkdgxp";
    })
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) unfreePackages;

  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    rnix-lsp
  ] ++ map (name: pkgs.${name}) unfreePackages;

  services = {
    sshd.enable = true;
    vscode-server.enable = true;
    xserver = {
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    xrdp = {
      enable = true;
      defaultWindowManager = "xfce4-session";
    };
    zerotierone.enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 3389 ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  boot.binfmt.emulatedSystems = [
    "riscv64-linux"
    "x86_64-linux"
  ];
}
