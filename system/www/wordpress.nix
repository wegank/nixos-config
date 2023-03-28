{ config, ... }:

{
  security.acme.certs."in.con.nu" = {
    webroot = "/var/lib/acme/in.con.nu";
  };

  services.wordpress = {
    webserver = "nginx";
    sites."in.con.nu" = { };
  };

  services.nginx.virtualHosts."in.con.nu" = {
    forceSSL = true;
    useACMEHost = "in.con.nu";
  };
}
