{
  owner,
  ...
}:

{
  imports = [ ./sys/brew.nix ];

  users.users.${owner.name} = {
    home = "/Users/${owner.name}";
  };

  system.primaryUser = owner.name;

  # Set state version.
  system.stateVersion = 6;
}
