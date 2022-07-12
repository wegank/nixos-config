{ config, owner, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      root = "/var/www/localhost";
      locations = {
        "= /".extraConfig = ''
          rewrite ^ /index.php;
        '';
        "~ \.php$".extraConfig = ''
          fastcgi_pass  unix:${config.services.phpfpm.pools."localhost".socket};
          fastcgi_index index.php;
        '';
      };
    };
  };

  services.phpfpm.pools."localhost" = {
    user = "nobody";
    settings = {
      pm = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 80 443 ];
    };
  };
}
