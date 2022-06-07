{ autoreconfHook
, clangStdenv
, fetchFromGitHub
, elfutils
, flex
, lib
, llvm
, pkg-config
, which
, zlib
}:

clangStdenv.mkDerivation rec {
  pname = "nvc";
  version = "1.7-devel";

  src = fetchFromGitHub {
    owner = "nickg";
    repo = "${pname}";
    rev = "71fa94bb99f91214ec6f9c5cc0abd857c324857c";
    sha256 = "sha256-nNYyJ1FBsTOR23EmKdLMZbcUBE8E2CHAArrK8JpPix0=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];

  buildInputs = [
    elfutils
    flex
    llvm
    which
    zlib
  ];

  prePatch = ''
    sed -i "720,724d;738d" src/util.c
  '';

  preConfigure = ''
    mkdir build && cd build
  '';

  configureScript = "../configure";

  meta = with lib; {
    description = "VHDL compiler and simulator";
    homepage = "https://www.nickg.me.uk/nvc/";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
    maintainers = with maintainers; [ wegank ];
  };
}
