{ owner, pkgs, ... }:

{
  services.xserver.desktopManager.phosh = {
    enable = true;
    user = owner.name;
    group = "users";
  };

  programs.calls.enable = true;

  hardware.sensor.iio.enable = true;

  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    chatty
    kgx
    megapixels
  ];

  users.extraUsers.${owner.name} = {
    extraGroups = [
      "dialout"
      "feedbackd"
      "video"
    ];
  };
}
