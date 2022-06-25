{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cloudflared
  ];
}
