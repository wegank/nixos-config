{
  pkgs,
  ...
}:

{
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      browsing = true;
      browsedConf = ''
        BrowseRemoteProtocols dnssd cups
        LocalQueueNamingRemoteCUPS RemoteName
        CreateIPPPrinterQueues All
      '';
      drivers = with pkgs; [
        gutenprint
      ];
    };
  };
}
