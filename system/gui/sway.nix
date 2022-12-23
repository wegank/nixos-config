{
  environment = {
    pathsToLink = [ "/libexec" ];
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = [ ];
    };
  };
}
