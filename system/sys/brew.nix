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
    "logitech-options"
    "microsoft-teams"
    "obs"
    "prolific-pl2303"
    "rectangle"
    "teamviewer"
    "tunnelblick"
    "utm"
    "vlc"
    "windscribe"
  ];
}
