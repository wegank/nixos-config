{ config, pkgs, ... }:

{
  imports = [
    (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
  ];

  services = {
    xserver = {
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    sshd.enable = true;
    vscode-server.enable = true;
    xrdp = {
      enable = true;
      defaultWindowManager = "xfce4-session";
    };
  };

  networking.firewall.allowedTCPPorts = [ 3389 ];

  boot.binfmt.emulatedSystems = [
    "riscv64-linux"
  ];
}
