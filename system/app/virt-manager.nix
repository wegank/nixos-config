{ lib, pkgs, owner, isLinux, isDarwin, ... }:

{
  environment.systemPackages = with pkgs; [
    (virt-manager.overrideAttrs (old: {
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
