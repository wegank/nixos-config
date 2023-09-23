{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.brews = [
    "gmp"
  ];

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
    "paraview"
    "playcover-community"
    "prolific-pl2303"
    "teamviewer"
    "tunnelblick"
    "vcv-rack"
    "vlc"
    "windscribe"
    "zulip"
  ];
}
