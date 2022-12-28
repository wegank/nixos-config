{
  environment = {
    pathsToLink = [ "/libexec" ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = [ ];
    };
  };
}
