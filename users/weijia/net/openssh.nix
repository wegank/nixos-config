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
      "sysal" = {
        proxyJump = "ssh.lip6.fr";
        user = "weijia";
      };
      "tibre" = {
        proxyJump = "ssh.lip6.fr";
        user = "weijia";
      };
      "triade" = {
        proxyJump = "ssh.lip6.fr";
        user = "weijia";
      };
      "weijia.perso.lip6.fr" = {
        proxyJump = "ssh.lip6.fr";
        user = "weijia";
      };
    };
  };
}
