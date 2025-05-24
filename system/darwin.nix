{ owner, lib, ... }:

{
  imports = [ ./sys/brew.nix ];

  users.users.${owner.name} = {
    home = "/Users/${owner.name}";
  };

  ids.uids.nixbld = lib.mkForce 350;

  system.primaryUser = owner.name;

  # Set state version.
  system.stateVersion = 4;
}
