{ owner, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = owner.email;
  };

  users.users.nginx.extraGroups = [ "acme" ];

  services.nginx.enable = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
