{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "ssh.lip6.fr" = {
        user = "weijia";
      };
      "posso" = {
        proxyJump = "ssh.lip6.fr";
        user = "weijia";
      };
    };
  };
}
