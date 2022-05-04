{ owner, ... }:

{
  services.httpd = {
    enable = true;
    adminAddr = owner.gitEmail;
    enablePHP = true;
    virtualHosts."localhost" = {
      documentRoot = "/var/www/localhost";
      extraConfig = ''
        <Directory />
          DirectoryIndex index.php
          Require all granted
        </Directory>
      '';
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 80 443 ];
    };
  };
}
