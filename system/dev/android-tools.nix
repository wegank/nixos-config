{ owner, ... }:

{
  users.extraUsers.${owner.name} = {
    extraGroups = [
      "adbusers"
    ];
  };
}
