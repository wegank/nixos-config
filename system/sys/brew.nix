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
    "PlayCover/playcover"
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
    "logi-options-plus"
    "microsoft-teams"
    "obs"
    "playcover-community"
    "prolific-pl2303"
    "rectangle"
    "teamviewer"
    "tunnelblick"
    "utm"
    "vcv-rack"
    "vlc"
    "windscribe"
  ];
}
