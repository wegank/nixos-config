{ config, lib, owner, pkgs, ... }:

let
  domain = "cloud.weijia.wang";
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    config = {
      adminuser = owner.name;
      adminpassFile = "${pkgs.writeText "adminPass" owner.initialPassword}";
      dbtype = "mysql";
    };
    database.createLocally = true;
    extraOptions.default_phone_region = "FR";
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
