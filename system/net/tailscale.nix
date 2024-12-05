{
  isHomeServer,
  ...
}:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = if isHomeServer then "server" else "none";
  };
}
