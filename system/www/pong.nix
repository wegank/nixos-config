{ config, pkgs, ... }:

let
  url = "http://localhost:3000";
in
{
  services.nginx = {
    enable = true;
    virtualHosts."pong.weijia.wang" = {
      root = "/var/www/pong-client";
      listen = [
        { addr = "0.0.0.0"; port = 3000; }
      ];
    };
  };

  systemd.user.services = {
    "pong.weijia.wang" = {
      description = "Pong";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --name pong --url ${url}";
      };
    };
  };
}
