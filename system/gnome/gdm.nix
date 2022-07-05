{ owner, ... }:

{
  services.xserver.displayManager = {
    gdm.enable = true;
    autoLogin = {
      enable = true;
      user = owner.name;
    };
  };
}
