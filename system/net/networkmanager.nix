{ owner, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online = {
    enable = false;
  };

  users.extraUsers.${owner.name} = {
    extraGroups = [ "networkmanager" ];
  };
}
