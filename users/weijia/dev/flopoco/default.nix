{ bison
, boost
, cmake
, fetchFromGitLab
, flex
, gmp
, installShellFiles
, lib
, libxml2
, mpfi
, mpfr
, pkgs
, sollya
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "flopoco";
  version = "4.1.1";

  src = fetchFromGitLab {
    owner = pname;
    repo = pname;
    rev = "${pname}-${version}";
    sha256 = "sha256-H/OMzfTzzDmqvrvRWgxQmt/uhc0BVj1KhyKerpBE1ME=";
  };

  nativeBuildInputs = [
    cmake
    installShellFiles
  ];

  buildInputs = [
    bison
    boost
    flex
    gmp
    libxml2
    mpfi
    mpfr
    (pkgs.callPackage ./pagsuite/default.nix { })
    (pkgs.callPackage ./scalp/default.nix { })
    sollya
    (pkgs.callPackage ./wcpg/default.nix { })
  ];

  installPhase = ''
    ./${pname} BuildAutocomplete
    install -D ./${pname} $out/bin/${pname}
    installShellCompletion --bash ${pname}_autocomplete
  '';

  meta = with lib; {
    description = "The FloPoCo arithmetic core generator";
    homepage = "http://flopoco.org";
    license = licenses.agpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ wegank ];
  };
}
