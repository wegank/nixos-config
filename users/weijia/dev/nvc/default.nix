{ autoreconfHook
, clangStdenv
, check
, elfutils
, fetchFromGitHub
, flex
, lib
, libelf
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
    rev = "bf49b3b0452bd2e89d180cfcf4e677a41848fecc";
    sha256 = "sha256-1adtcuOPkSAlmCDxW+dssZukQY2K8eYhnecHgvZIZHE=";
  };

  nativeBuildInputs = [
    autoreconfHook
    check
    flex
    pkg-config
    which
  ];

  buildInputs = [
    llvm
    zlib
  ] ++ (if clangStdenv.isLinux then [
    elfutils
  ] else [
    libelf
  ]);

  prePatch = lib.optionalString
    (clangStdenv.isLinux && !clangStdenv.isx86_64) ''
    sed -i "730,734d;748d" src/util.c
  '';

  preConfigure = ''
    mkdir build && cd build
  '';

  configureScript = "../configure";

  # doCheck = true;

  meta = with lib; {
    description = "VHDL compiler and simulator";
    homepage = "https://www.nickg.me.uk/nvc/";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ wegank ];
  };
}
