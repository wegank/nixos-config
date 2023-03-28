{ owner, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = owner.email;
  };

  services.nginx.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
