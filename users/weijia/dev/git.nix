{ pkgs, owner, ... }:

{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = owner.fullName;
      userEmail = owner.gitEmail;
    };
  };
}
