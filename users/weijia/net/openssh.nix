{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
      "nanmen" = {
        hostname = "120.202.241.46";
        port = 32203;
        user = "wegank";
      };
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
