{
  config,
  pkgs,
  owner,
  ...
}:

let
  domain = "me.con.nu";
in
{
  services.harmonia.enable = true;
  services.harmonia.signKeyPaths = [ "/var/lib/secrets/harmonia.secret" ];

  nix.settings.allowed-users = [ "harmonia" ];

  networking.firewall.allowedTCPPorts = [
    80
  ];

  services.nginx = {
    enable = true;
    virtualHosts.${domain} = {

      locations."/".extraConfig = ''
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_redirect http:// https://;
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
      '';
    };
  };

  services.frp = {
    enable = true;
    role = "client";
    settings = {
      common = {
        server_addr = "5.39.78.26";
        server_port = 7000;
        "auth.tokenSource.type" = "file";
        "auth.tokenSource.file.path" = "/var/lib/secrets/frp.secret";
      };
      harmonia = {
        type = "http";
        local_ip = "127.0.0.1";
        local_port = 80;
        custom_domains = domain;
      };
    };
  };
}
