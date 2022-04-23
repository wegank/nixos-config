{ lib
, config
, stdenv
, fetchurl
, fetchpatch
, fetchFromGitHub

, intltool
, pkg-config

, boost
, dos2unix
, ffmpeg
, ffms
, fftw
, fontconfig
, freetype
, icu
, libGL
, libGLU
, libX11
, libass
, libiconv
, lua5_1
, makeWrapper
, wxGTK30-gtk3
, zlib

, spellcheckSupport ? true
, hunspell ? null

, openalSupport ? false
, openal ? null

, alsaSupport ? stdenv.isLinux
, alsa-lib ? null

, pulseaudioSupport ? config.pulseaudio or stdenv.isLinux
, libpulseaudio ? null

, portaudioSupport ? false
, portaudio ? null
}:

assert spellcheckSupport -> (hunspell != null);
assert openalSupport -> (openal != null);
assert alsaSupport -> (alsa-lib != null);
assert pulseaudioSupport -> (libpulseaudio != null);
assert portaudioSupport -> (portaudio != null);

let
  inherit (lib) optional;
in
stdenv.mkDerivation rec {
  pname = "aegisub";
  version = "3.2.2";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    name = pname;
    rev = "v${version}";
    sha256 = "sha256-iLfDv/pgBuP8drEGJ/hI4NsF7ScMdhE80at4GFiLLPE=";
  };

  patches = [
    # Compatibility with ICU 59
    (fetchpatch {
      url = "https://github.com/Aegisub/Aegisub/commit/dd67db47cb2203e7a14058e52549721f6ff16a49.patch";
      sha256 = "sha256-R2rN7EiyA5cuBYIAMpa0eKZJ3QZahfnRp8R4HyejGB8=";
    })

    # Compatbility with Boost 1.69
    (fetchpatch {
      url = "https://github.com/Aegisub/Aegisub/commit/c3c446a8d6abc5127c9432387f50c5ad50012561.patch";
      sha256 = "sha256-7nlfojrb84A0DT82PqzxDaJfjIlg5BvWIBIgoqasHNk=";
    })

    # Compatbility with make 4.3
    (fetchpatch {
      url = "https://github.com/Aegisub/Aegisub/commit/6bd3f4c26b8fc1f76a8b797fcee11e7611d59a39.patch";
      sha256 = "sha256-rG8RJokd4V4aSYOQw2utWnrWPVrkqSV3TAvnGXNhLOk=";
    })

    # Compatibility with ffms2
    (fetchpatch {
      url = "https://github.com/Aegisub/Aegisub/commit/1aa9215e7fc360de05da9b7ec2cd68f1940af8b2.patch";
      sha256 = "sha256-JsuI4hQTcT0TEqHHoSsGbuiTg4hMCH3Cxp061oLk8Go=";
    })

    ./update-ffms2.patch

    # Compatibility with X11
    (fetchpatch {
      url = "https://github.com/Aegisub/Aegisub/commit/7a6da26be6a830f4e1255091952cc0a1326a4520.patch";
      sha256 = "sha256-/aTcIjFlZY4N9+IyHL4nwR0hUR4HTJM7ibbdKmNxq0w=";
    })

    # Remove vendor luajit dependency
    (fetchpatch {
      url = "https://sources.debian.org/data/main/a/aegisub/3.2.2%2Bdfsg-6/debian/patches/remove-vendor-luajit-dependency.patch";
      sha256 = "sha256-XS+LW62J26YalL2qccQv3JJ+RwTGq4ew8Ig56+FebsA=";
    })
  ];

  nativeBuildInputs = [
    intltool
    pkg-config
  ];
  buildInputs = [
    boost
    dos2unix
    ffmpeg
    ffms
    fftw
    fontconfig
    freetype
    icu
    libGL
    libGLU
    libX11
    libass
    libiconv
    lua5_1
    makeWrapper
    wxGTK30-gtk3
    zlib
  ]
  ++ optional alsaSupport alsa-lib
  ++ optional openalSupport openal
  ++ optional portaudioSupport portaudio
  ++ optional pulseaudioSupport libpulseaudio
  ++ optional spellcheckSupport hunspell
  ;

  enableParallelBuilding = true;

  hardeningDisable = [
    "bindnow"
    "relro"
  ];

  postPatch = ''
    sed -i 's/-Wno-c++11-narrowing/-Wno-narrowing/' configure.ac src/Makefile
    find . -type f '(' -name "*.lua" -o -name "*.moon" ')' -print0 | xargs -0 dos2unix
    substituteInPlace tools/respack.lua --replace "/usr/bin/lua" "${lua5_1}/bin/lua"
  '';

  # compat with icu61+
  # https://github.com/unicode-org/icu/blob/release-64-2/icu4c/readme.html#L554
  CXXFLAGS = [ "-DU_USING_ICU_NAMESPACE=1" ];

  # this is fixed upstream though not yet in an officially released version,
  # should be fine remove on next release (if one ever happens)
  NIX_LDFLAGS = "-lpthread";

  postInstall = ''
    wrapProgram $out/bin/aegisub-* --prefix GDK_BACKEND : x11
    ln -s $out/bin/aegisub-* $out/bin/aegisub
  '';

  meta = with lib; {
    homepage = "https://github.com/Aegisub/Aegisub";
    description = "An advanced subtitle editor";
    longDescription = ''
      Aegisub is a free, cross-platform open source tool for creating and
      modifying subtitles. Aegisub makes it quick and easy to time subtitles to
      audio, and features many powerful tools for styling them, including a
      built-in real-time video preview.
    '';
    # The Aegisub sources are itself BSD/ISC, but they are linked against GPL'd
    # softwares - so the resulting program will be GPL
    license = licenses.bsd3;
    maintainers = [ maintainers.AndersonTorres ];
    platforms = platforms.linux;
  };
}
# TODO [ AndersonTorres ]: update to fork release