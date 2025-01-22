{
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    printing = {
      enable = true;
      browsing = true;
      browsedConf = ''
        BrowseRemoteProtocols dnssd cups
        LocalQueueNamingRemoteCUPS RemoteName
        CreateIPPPrinterQueues All
      '';
    };
  };
}
