{
  services = {
    xrdp = {
      enable = true;
      defaultWindowManager = "xfce4-session";
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 3389 ];
    };
  };
}
