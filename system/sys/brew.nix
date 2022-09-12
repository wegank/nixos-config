{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.taps = [
    "homebrew/cask-drivers"
  ];

  homebrew.casks = [
    "altserver"
    "balenaetcher"
    "element"
    "emacs"
    "gimp"
    "iterm2"
    "libreoffice"
    "obs"
    "prolific-pl2303"
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
