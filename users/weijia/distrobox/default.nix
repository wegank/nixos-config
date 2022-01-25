{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "distrobox";
  version = "1.2.12";

  src = fetchFromGitHub {
    owner = "89luca89";
    repo = pname;
    rev = version;
    sha256 = "sha256-mxTDQWZwIrifz4E7sLtH9aSik9dBgTEsBmItMMRaWTI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    $src/install -p $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/89luca89/distrobox";
    description = "Use any Linux distribution inside your terminal.";
    longDescription = ''
      Use any Linux distribution inside your terminal. Distrobox uses podman 
      or docker to create containers using the Linux distribution of your 
      choice. The created container will be tightly integrated with the host, 
      allowing sharing of the HOME directory of the user, external storage, 
      external USB devices and graphical apps (X11/Wayland), and audio.
    '';
    license = licenses.gpl3;
    maintainers = with maintainers; [ wegank ];
    platforms = platforms.linux;
  };
}
