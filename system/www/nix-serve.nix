{ config, pkgs, ... }:

let
  url = "http://localhost:${toString config.services.nix-serve.port}";
in
{
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };

  services.nginx = {
    enable = true;
    virtualHosts."cache.weijia.wang" = {
      locations."/".extraConfig = ''
        proxy_pass ${url};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      '';
    };
  };

  systemd.user.services = {
    "cache.weijia.wang" = {
      description = "Nix Binary Cache";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --name cache --url ${url}";
      };
    };
  };
}
