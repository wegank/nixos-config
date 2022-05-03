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
    "tunnelblick"
    "utm"
    "vlc"
    "xquartz"
    "zerotier-one"
  ];
}
