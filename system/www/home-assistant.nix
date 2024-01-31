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
  };
}
