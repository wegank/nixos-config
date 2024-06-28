{ pkgs, owner, ... }:

{
  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

  users.users.${owner.name}.shell = pkgs.fish;
}
