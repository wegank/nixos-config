{ cmake
, fetchgit
, lib
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "scalp";
  version = "63";

  src = fetchgit {
    url = "https://digidev.digi.e-technik.uni-kassel.de/git/scalp.git";
    sha256 = "sha256-NyMZdJwdD3FR6uweYCclJjfcf3Y24Bns1ViwsmJ5izg=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = with lib; {
    description = "Scalable Linear Programming Library";
    homepage = "https://digidev.digi.e-technik.uni-kassel.de/scalp/";
    license = licenses.lgpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ wegank ];
  };
}
