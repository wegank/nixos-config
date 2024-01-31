{ ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  services.home-assistant = {
    enable = true;
    config = {
      default_config = { };
    };
    extraComponents = [
      "bthome"
      "esphome"
      "google_translate"
      "met"
      "radio_browser"
      "yeelight"
    ];
  };
}
