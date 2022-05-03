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
    "teamviewer"
    "tunnelblick"
    "utm"
    "vlc"
  ];
}
