{ pkgs, owner, ... }:

{
  home = {
    packages = with pkgs; [
      git-filter-repo
    ];
  };

  programs = {
    gh = {
      enable = true;
      settings = {
        version = "1";
      };
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = owner.fullName;
      userEmail = owner.gitEmail;
    };
  };
}
