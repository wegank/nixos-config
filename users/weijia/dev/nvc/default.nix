{ autoreconfHook
, fetchFromGitHub
, flex
, lib
, llvm
, stdenv
, which
, zlib
}:

stdenv.mkDerivation rec {
  pname = "nvc";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "nickg";
    repo = "${pname}";
    rev = "r${version}";
    sha256 = "sha256-BtUMpT1MKRFGRlIbCEGo4OBZ/r9es1VRmJdgmk1oZFQ=";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    flex
    llvm
    which
    zlib
  ];

  meta = with lib; {
    description = "VHDL compiler and simulator";
    homepage = "https://www.nickg.me.uk/nvc/";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
    maintainers = with maintainers; [ wegank ];
  };
}
