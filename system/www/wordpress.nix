{ config, pkgs, ... }:

let
  domain = "in.con.nu";
in
{
  services.wordpress = {
    webserver = "nginx";
    sites.${domain} = {
      package = with pkgs; wordpress.overrideAttrs (old: rec {
        version = "6.2";
        src = fetchurl {
          url = "https://wordpress.org/${old.pname}-${version}.tar.gz";
          hash = "sha256-FDEo3rZc7SU9yqAplUScSMUWOEVS0e/PsrOPjS9m+QQ=";
        };
      });
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
