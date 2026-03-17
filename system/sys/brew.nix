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
    "llvm"
    "mpfr"
  ];

  homebrew.taps = [
    "homebrew/cask-drivers"
  ];

  homebrew.casks = [
    "altserver"
    "element"
    "gimp"
    "iterm2"
    "libreoffice"
    "obs"
    "prolific-pl2303"
    "sage"
    "teamviewer"
    "tunnelblick"
    "vlc"
    "windscribe"
    "zulip"
  ];
}
