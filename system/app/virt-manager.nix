{
  lib,
  pkgs,
  owner,
  isLinux,
  ...
}:

{
  environment.systemPackages = with pkgs; [ virt-manager ];
}
// lib.optionalAttrs isLinux {
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  users.users.${owner.name}.extraGroups = [ "libvirtd" ];
}
