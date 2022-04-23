{
  homebrew = {
    enable = true;
    autoUpdate = true;
    brewPrefix = "/opt/homebrew/bin";
    cleanup = "zap";
    casks = [
      "altserver"
      "balenaetcher"
      "emacs"
      "gimp"
      "iterm2"
      "obs"
      "rectangle"
      "utm"
      "vlc"
      "xquartz"
      "zerotier-one"
    ];
  };
}
