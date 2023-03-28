{ config, ... }:

let
  domain = "in.con.nu";
in
{
  services.wordpress = {
    webserver = "nginx";
    sites.${domain} = { };
  };

  security.acme.certs.${domain} = {
    webroot = "/var/lib/acme/${domain}";
  };

  services.nginx.virtualHosts.${domain} = {
    forceSSL = true;
    useACMEHost = domain;
    acmeRoot = config.security.acme.certs.${domain}.webroot;
  };
}
