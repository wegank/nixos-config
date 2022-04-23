{
  imports = [
    (fetchTarball {
      url = https://github.com/msteen/nixos-vscode-server/tarball/bc28cc2a7d866b32a8358c6ad61bea68a618a3f5;
      sha256 = "00aqwrr6bgvkz9bminval7waxjamb792c0bz894ap8ciqawkdgxp";
    })
  ];

  services = {
    vscode-server = {
      enable = true;
    };
  };
}
