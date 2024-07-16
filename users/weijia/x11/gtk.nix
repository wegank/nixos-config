{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans 10";
      package = pkgs.noto-fonts;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  home = {
    packages = with pkgs; [
      gsettings-desktop-schemas
      gtk-engine-murrine
      gtk_engines
      lxappearance
    ];
  };
}
