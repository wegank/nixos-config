{ lib, pkgs, ... }:

let
  qemu-user-arm = pkgs.qemu.override {
    smartcardSupport = false;
    spiceSupport = false;
    openGLSupport = false;
    virglSupport = false;
    vncSupport = false;
    gtkSupport = false;
    sdlSupport = false;
    pulseSupport = false;
    smbdSupport = false;
    seccompSupport = false;
    hostCpuTargets = [ "arm-linux-user" ];
  };
in
{
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  boot.binfmt = {
    emulatedSystems = [ "armv7l-linux" ];
    registrations.armv7l-linux = {
      interpreter = lib.mkForce "${qemu-user-arm}/bin/qemu-arm";
    };
  };
}
