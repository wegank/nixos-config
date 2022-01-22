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
  };

  boot.binfmt.emulatedSystems = [
    "riscv64-linux"
  ];
}
