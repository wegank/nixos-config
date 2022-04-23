{ owner, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  users.extraUsers.${owner.name} = {
    extraGroups = [
      "networkmanager"
    ];
  };
}
