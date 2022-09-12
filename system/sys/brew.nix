{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.casks = [
    "altserver"
    "balenaetcher"
    "element"
    "emacs"
    "gimp"
    "iterm2"
    "libreoffice"
    "obs"
    "r"
    "rectangle"
    "rstudio"
    "teamviewer"
    "tunnelblick"
    "utm"
    "vlc"
    "windscribe"
  ];
}
