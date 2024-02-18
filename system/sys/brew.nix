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
    "gimp"
    "iterm2"
    "libreoffice"
    "logi-options-plus"
    "microsoft-teams"
    "obs"
    "playcover-community"
    "prolific-pl2303"
    "sage"
    "teamviewer"
    "tunnelblick"
    "vcv-rack"
    "vlc"
    "windscribe"
    "zulip"
  ];
}
