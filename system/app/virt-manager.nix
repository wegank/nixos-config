{ lib, pkgs, owner, isLinux, ... }:

{
  environment.systemPackages = with pkgs; [
    (virt-manager.overrideAttrs (old: {
      buildInputs = lib.lists.remove pkgs.desktopToDarwinBundle old.buildInputs;
    }))
  ];
} // lib.optionalAttrs isLinux {
  virtualisation.libvirtd.enable = true;

  users.users.${owner.name}.extraGroups = [
    "libvirtd"
  ];
}
