{ ... }:

{
  services.wordpress = {
    webserver = "nginx";
    sites."in.con.nu" = {
      virtualHost = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };
}
