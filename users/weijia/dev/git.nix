{ pkgs, owner, ... }:

{
  home = {
    packages = with pkgs; [
      gh
      git-filter-repo
    ];
  };

  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = owner.fullName;
      userEmail = owner.gitEmail;
    };
  };
}
