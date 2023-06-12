{ lib, pkgs, owner, isLinux, isDarwin, ... }:

{
  environment.systemPackages = with pkgs; [
    ((virt-manager.override {
      xorriso = pkgs.xorriso.overrideAttrs (old: {
        env.NIX_CFLAGS_COMPILE = lib.optionalString isDarwin "-include unistd.h";
      });
    }).overrideAttrs (old: {
      disabledTestPaths = (old.disabledTestPaths or [ ]) ++ lib.optionals isDarwin [
        "tests/test_checkprops.py"
        "tests/test_cli.py"
      ];
    }))
  ];
} // lib.optionalAttrs isLinux {
  virtualisation.libvirtd.enable = true;

  users.users.${owner.name}.extraGroups = [
    "libvirtd"
  ];
}
