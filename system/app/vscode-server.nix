{
  imports = [
    (fetchTarball {
      url = https://github.com/msteen/nixos-vscode-server/tarball/178c809a9dbd3f4df25ed7fbe23a52c35233502d;
      sha256 = "sha256:0a62zj4vlcxjmn7a30gkpq3zbfys3k1d62d9nn2mi42yyv2hcrm1";
    })
  ];

  services = {
    vscode-server = {
      enable = true;
    };
  };
}
