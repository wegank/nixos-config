{ lib, pkgs, owner, isLinux, ... }:

{
  environment.systemPackages = with pkgs; [
    (virt-manager.override {
      spice-gtk = spice-gtk.overrideAttrs (old: {
        mesonFlags = old.mesonFlags ++ lib.optionals (!isLinux) [
          "-Degl=disabled"
        ];
      });
    })
  ];
} // lib.optionalAttrs isLinux {
  virtualisation.libvirtd.enable = true;

  users.users.${owner.name}.extraGroups = [
    "libvirtd"
  ];
}
