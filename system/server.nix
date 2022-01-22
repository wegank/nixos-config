{ config, pkgs, ... }:

{
  services = {
    xserver = {
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };
    sshd.enable = true;
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
