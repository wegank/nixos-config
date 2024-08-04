{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.brews = [ "gmp" ];

  homebrew.taps = [
    "PlayCover/playcover"
    "homebrew/cask-drivers"
  ];

  homebrew.casks = [
    "altserver"
    "chatgpt"
    "element"
    "gimp"
    "iterm2"
    "libreoffice"
    "obs"
    "playcover-community"
    "prolific-pl2303"
    "sage"
    "teamviewer"
    "tunnelblick"
    "vlc"
    "windscribe"
    "zulip"
  ];
}
