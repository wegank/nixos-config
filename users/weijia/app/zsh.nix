{ pkgs, lib, host, ... }:

let
  isLinux = lib.strings.hasSuffix "linux" host.platform;
  darwinEnv =
    "export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}\n";
in
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = (
          if host.profile == "desktop" then
            "agnoster"
          else
            "robbyrussell"
        );
      };
      envExtra = lib.optionalString (!isLinux) darwinEnv;
    };
  };
}
