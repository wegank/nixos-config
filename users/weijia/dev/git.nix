{
  pkgs,
  isDarwin,
  owner,
  ...
}:

{
  home = {
    packages = with pkgs; [ git-filter-repo ];
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
      package = if isDarwin then pkgs.git else pkgs.gitAndTools.gitFull;
      settings = {
        user.name = owner.fullName;
        user.email = owner.gitEmail;
      };
    };

    gpg = {
      enable = true;
    };
  };
}
