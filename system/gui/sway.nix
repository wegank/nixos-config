{
  services = {
    xserver = {
      displayManager = {
        defaultSession = "sway";
      };
    };
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = [ ];
    };
  };
}
