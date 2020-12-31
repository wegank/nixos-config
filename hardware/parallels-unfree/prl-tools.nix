{ stdenv, lib, makeWrapper, p7zip
, gawk, utillinux, xorg, glib, dbus-glib, zlib
, kernel ? null, libsOnly ? false
, fetchurl, undmg, perl, autoPatchelfHook
}:

assert (!libsOnly) -> kernel != null;

let xorgFullVer = lib.getVersion xorg.xorgserver;
    xorgVer = lib.versions.majorMinor xorgFullVer;
    x64 = if stdenv.hostPlatform.system == "x86_64-linux" then true
          else if stdenv.hostPlatform.system == "i686-linux" then false
          else throw "Parallels Tools for Linux only support {x86-64,i686}-linux targets";
in
stdenv.mkDerivation rec {
  version = "${prl_major}.1.2-49151";
  prl_major = "16";
  pname = "prl-tools";

  # We download the full distribution to extract prl-tools-lin.iso from
  # => ${dmg}/Parallels\ Desktop.app/Contents/Resources/Tools/prl-tools-lin.iso
  src = fetchurl {
    url =  "https://download.parallels.com/desktop/v${prl_major}/${version}/ParallelsDesktop-${version}.dmg";
    sha256 = "1zy0yssf91qvvd86bij73p272xzjyvvnlg45pim4cd2wk16j1864";
  };

  hardeningDisable = [ "pic" "format" ];

  nativeBuildInputs = [ p7zip undmg perl autoPatchelfHook ] 
    ++ lib.optionals (!libsOnly) [ makeWrapper ] ++ kernel.moduleBuildDependencies;

  buildInputs = with xorg; [ stdenv.cc.cc libXrandr libXext libX11 libXcomposite libXinerama ]
    ++ lib.optionals (!libsOnly) [ libXi glib dbus-glib zlib ];

  inherit libsOnly;

  unpackPhase = ''
    undmg < "${src}" || true

    export sourceRoot=prl-tools-build
    7z x "Parallels Desktop.app/Contents/Resources/Tools/prl-tools-lin.iso" -o$sourceRoot
    if test -z "$libsOnly"; then
      ( cd $sourceRoot/kmods; tar -xaf prl_mod.tar.gz )
    fi
    ( cd $sourceRoot/tools/tools${if x64 then "64" else "32"} )
  '';

  patches = if stdenv.lib.versionAtLeast kernel.version "5.9" then [ ./prl-tools.patch ] else [ ];

  kernelVersion = if libsOnly then "" else lib.getVersion kernel.name;
  kernelDir = if libsOnly then "" else "${kernel.dev}/lib/modules/${kernelVersion}";
  scriptPath = lib.concatStringsSep ":" (lib.optionals (!libsOnly) [ "${utillinux}/bin" "${gawk}/bin" ]);

  buildPhase = ''
    if test -z "$libsOnly"; then
      ( # kernel modules
        cd kmods
        make -f Makefile.kmods \
          KSRC=$kernelDir/source \
          HEADERS_CHECK_DIR=$kernelDir/source \
          KERNEL_DIR=$kernelDir/build \
          SRC=$kernelDir/build \
          KVER=$kernelVersion
      )
    fi
  '';

  installPhase = ''
    if test -z "$libsOnly"; then
      ( # kernel modules
        cd kmods
        mkdir -p $out/lib/modules/${kernelVersion}/extra
        cp prl_eth/pvmnet/prl_eth.ko $out/lib/modules/${kernelVersion}/extra
        cp prl_tg/Toolgate/Guest/Linux/prl_tg/prl_tg.ko $out/lib/modules/${kernelVersion}/extra
        cp prl_fs/SharedFolders/Guest/Linux/prl_fs/prl_fs.ko $out/lib/modules/${kernelVersion}/extra
        cp prl_fs_freeze/Snapshot/Guest/Linux/prl_freeze/prl_fs_freeze.ko $out/lib/modules/${kernelVersion}/extra
        cp prl_vid/Video/Guest/Linux/kmod/prl_vid.ko $out/lib/modules/${kernelVersion}/extra
      )
    fi

    ( # tools
      cd tools/tools${if x64 then "64" else "32"}
      mkdir -p $out/lib

      if test -z "$libsOnly"; then
        # install binaries
        for i in bin/* sbin/prl_nettool sbin/prl_snapshot; do
          install -Dm755 $i $out/$i
        done

        mkdir -p $out/bin
        install -Dm755 ../../tools/prlfsmountd.sh $out/sbin/prlfsmountd
        wrapProgram $out/sbin/prlfsmountd \
          --prefix PATH ':' "$scriptPath"

        for i in lib/*.0.0; do
          cp $i $out/lib
        done

        mkdir -p $out/lib/udev/rules.d
        install -Dm644 ../xorg-prlmouse.rules $out/lib/udev/rules.d/69-xorg-prlmouse.rules
        
        mkdir -p $out/etc/udev/rules.d
        sed 's,/bin/sh,${stdenv.shell},g' ../parallels-video.rules > ../parallels-video.rules
        install -Dm644 ../parallels-video.rules $out/etc/udev/rules.d/99-parallels-video.rules

        mkdir -p $out/share/man/man8
        install -Dm644 ../mount.prl_fs.8 $out/share/man/man8

        mkdir -p $out/etc/pm/sleep.d
        install -Dm644 ../99prltoolsd-hibernate $out/etc/pm/sleep.d

        (
          cd xorg.${xorgVer}
          # Install the X modules.
          (
            cd x-server/modules
            for i in */*; do
              install -Dm755 $i $out/lib/xorg/modules/$i
            done
          )
          (
            cd usr/lib
            libGLXname=$(echo libglx.so*)
            install -Dm755 $libGLXname $out/lib/xorg/modules/extensions/$libGLXname
            # disabled libglx.so; won't boot
            # ln -s $libGLXname $out/lib/xorg/modules/extensions/libglx.so
            # ln -s $libGLXname $out/lib/xorg/modules/extensions/libglx.so.1
          )
        )

        (
          cd x-server/modules
          for i in */*; do
            install -Dm755 $i $out/lib/$i
            install -Dm755 $i $out/lib/xorg/modules/$i
          done
        )
      fi
      
      mkdir -p $out/lib/drivers
      
      perl -pi -e 's/prl_vtg/\/prl_tg/s' $out/lib/xorg/modules/drivers/prlvidel_drv.so
      cp $out/lib/xorg/modules/drivers/prlvidel_drv.so $out/lib/drivers/prlvidel_drv.so

      cd $out/lib
      ln -s libGL.so.1.0.0 libGL.so
      ln -s libGL.so.1.0.0 libGL.so.1
      ln -s libPrlDRI.so.1.0.0 libPrlDRI.so.1
      ln -s libPrlWl.so.1.0.0 libPrlWl.so.1
      ln -s libEGL.so.1.0.0 libEGL.so.1
      ln -s libgbm.so.1.0.0 libgbm.so.1
    )
  '';

  meta = with stdenv.lib; {
    description = "Parallels Tools for Linux guests";
    homepage = "https://parallels.com";
    platforms = [ "i686-linux" "x86_64-linux" ];
    license = licenses.unfree;
    # I was making this package blindly and requesting testing from the real user,
    # so I can't even test it by myself and won't provide future updates.
    maintainers = with maintainers; [ abbradar ];
    priority = 4;
  };
}
