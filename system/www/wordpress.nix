{ config, pkgs, ... }:

let
  domain = "in.con.nu";
  version = "6.2";
in
{
  services.wordpress = {
    webserver = "nginx";
    sites.${domain} = {
      package = with pkgs; wordpress.overrideAttrs (old: {
        inherit version;
        src = fetchurl {
          url = "https://wordpress.org/${old.pname}-${version}.tar.gz";
          hash = "sha256-FDEo3rZc7SU9yqAplUScSMUWOEVS0e/PsrOPjS9m+QQ=";
        };
      });
      languages = with pkgs; [
        (stdenvNoCC.mkDerivation {
          pname = "wordpress-language-fr";
          inherit version;
          src = fetchurl {
            url = "https://fr.wordpress.org/wordpress-${version}-fr_FR.tar.gz";
            hash = "sha256-H87YguPOQuuPH5T6G9AbJbCmAZmhAt2A21pNcbUnIgM=";
          };
          installPhase = ''
            runHook preInstall

            mkdir -p $out
            cp -r ./wp-content/languages/* $out/

            runHook postInstall
          '';
        })
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
