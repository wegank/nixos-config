{ owner, ... }:

{
  services.xserver.desktopManager.phosh = {
    enable = true;
    user = owner.name;
    group = "users";
  };

  programs.calls.enable = true;
  hardware.sensor.iio.enable = true;

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
