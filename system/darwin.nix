{ owner, ... }:

{
  imports = [
    ./sys/brew.nix
  ];

  users.users.${owner.name} = {
    home = "/Users/${owner.name}";
  };

  # Set state version.
  system.stateVersion = 4;
}
