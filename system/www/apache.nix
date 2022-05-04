{ owner, ... }:

{
  services.httpd = {
    enable = true;
    adminAddr = owner.gitEmail;
    enablePHP = true;
    virtualHosts."localhost" = {
      documentRoot = "/var/www/localhost";
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 80 443 ];
    };
  };
}
