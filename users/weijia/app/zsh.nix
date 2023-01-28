{ lib, isDarwin, isDesktop, ... }:

let
  darwinEnv = ''
    . "$HOME/.cargo/env"
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels''${NIX_PATH:+:$NIX_PATH}
    export PATH=~/.npm-global/bin:$PATH
  '';

  darwinInit = ''
  '';
in
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = if isDesktop then "agnoster" else "robbyrussell";
      };
      envExtra = lib.optionalString isDarwin darwinEnv;
      initExtra = lib.optionalString isDarwin darwinInit;
      profileExtra = lib.optionalString isDarwin "\n";
    };
  };
}
