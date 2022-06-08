{ pkgs, config ? pkgs.config, isDarwin, isLinux, ... }:

let
  androidEnvNixpkgs = fetchTarball {
    name = "androidenv";
    url = "https://github.com/NixOS/nixpkgs/archive/1fdeb86121ab6e5101e52b3fa2a6d8ebff740100.tar.gz";
    sha256 = "sha256:0xg5lik0bl4ml6spyhwf644cd67gvs5xy5ffzh64dfsrzfapkjn7";
  };

  androidEnv = pkgs.callPackage "${androidEnvNixpkgs}/pkgs/development/mobile/androidenv" {
    inherit config pkgs;
    licenseAccepted = true;
  };

  androidComposition = androidEnv.composeAndroidPackages {
    platformToolsVersion = "33.0.1";
  };
in
{
  home.packages = with pkgs; lib.optionals isDarwin [
    androidComposition.platform-tools
  ] ++ lib.optionals isLinux [
    android-tools
  ];
}
