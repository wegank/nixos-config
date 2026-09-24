{
  owner,
  pkgs,
  ...
}:

{
  imports = [ ./sys/brew.nix ];

  users.users.${owner.name} = {
    home = "/Users/${owner.name}";
  };

  environment.systemPackages = with pkgs; [
    macaulay2
  ];

  system.primaryUser = owner.name;

  # Set state version.
  system.stateVersion = 6;
}
