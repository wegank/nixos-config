{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = false;
        Compression = false;
        ControlMaster = false;
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = false;
        ForwardAgent = false;
        ServerAliveCountMax = 3;
        ServerAliveInterval = 0;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
      };
      "nanmen" = {
        HostName = "120.202.241.46";
        Port = 32203;
        User = "wegank";
      };
      "ssh.lip6.fr" = {
        User = "weijia";
      };
      "groebner" = {
        ProxyJump = "ssh.lip6.fr";
        User = "weijia";
      };
      "posso" = {
        ProxyJump = "ssh.lip6.fr";
        User = "weijia";
      };
      "sysal" = {
        ProxyJump = "ssh.lip6.fr";
        User = "weijia";
      };
      "tibre" = {
        ProxyJump = "ssh.lip6.fr";
        User = "weijia";
      };
      "triade" = {
        ProxyJump = "ssh.lip6.fr";
        User = "weijia";
      };
      "weijia.perso.lip6.fr" = {
        ProxyJump = "ssh.lip6.fr";
        User = "weijia";
      };
    };
  };
}
