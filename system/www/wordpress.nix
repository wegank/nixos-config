{ config, pkgs, ... }:

let
  domain = "in.con.nu";
  version = "6.2";
in
{
  services.wordpress = {
    webserver = "nginx";
    sites.${domain} = {
      settings = {
        WPLANG = "fr_FR";
      };
    };
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
