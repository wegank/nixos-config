{ config, lib, owner, pkgs, ... }:

let
  domain = "cloud.weijia.wang";
  dbpass = "nextcloud";
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud26;
    config = {
      adminuser = owner.name;
      adminpassFile = "${pkgs.writeText "adminPass" owner.initialPassword}";
      dbtype = "mysql";
      dbpassFile = "${pkgs.writeText "dbPass" dbpass}";
      defaultPhoneRegion = "FR";
    };
    database.createLocally = true;
    enableBrokenCiphersForSSE = false;
    hostName = domain;
    https = true;
  };

  services.mysql.package = lib.mkForce pkgs.mariadb;

  security.acme.certs.${domain} = {
    webroot = "/var/lib/acme/${domain}";
  };

  services.nginx.virtualHosts.${domain} = {
    forceSSL = true;
    useACMEHost = domain;
    acmeRoot = config.security.acme.certs.${domain}.webroot;
  };
}
