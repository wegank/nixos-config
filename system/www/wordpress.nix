{ config, pkgs, ... }:

let
  domain = "in.con.nu";
in
{
  services.wordpress = {
    webserver = "nginx";
    sites.${domain} = {
      languages = [
        pkgs.wordpressPackages.languages.fr_FR
      ];
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
