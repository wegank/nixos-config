{ ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    config = {
      default_config = { };
    };
    extraComponents = [
      "bthome"
      "esphome"
      "google_translate"
      "homekit"
      "homekit_controller"
      "ibeacon"
      "kegtron"
      "met"
      "radio_browser"
      "xiaomi_ble"
      "yeelight"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    5353
    21064
  ];
}
