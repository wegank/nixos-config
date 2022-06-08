{
  homebrew = {
    enable = true;
    autoUpdate = true;
    brewPrefix = "/opt/homebrew/bin";
    cleanup = "zap";
  };

  homebrew.casks = [
    "altserver"
    "balenaetcher"
    "emacs"
    "gimp"
    "iterm2"
    "libreoffice"
    "obs"
    "rectangle"
    "rstudio"
    "teamviewer"
    "tunnelblick"
    "utm"
    "vlc"
  ];
}
