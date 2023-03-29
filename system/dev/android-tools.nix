{ lib, pkgs, owner, isLinux, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
  ];
} // lib.optionalAttrs isLinux {
  users.users.${owner.name} = {
    extraGroups = [
      "adbusers"
    ];
  };
}
