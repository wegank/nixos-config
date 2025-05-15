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
    "autoconf"
    "automake"
    "flint"
    "gmp"
    "libomp"
    "libtool"
    "M2"
    "mpfr"
  ];

  homebrew.taps = [
    "PlayCover/playcover"
    "homebrew/cask-drivers"
    "Macaulay2/tap"
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
