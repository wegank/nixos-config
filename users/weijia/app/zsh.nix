{ lib, isDarwin, isDesktop, ... }:

let
  darwinEnv =
    # Rustup
    ". \"$HOME/.cargo/env\"\n" +
    # Home Manager
    "export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}\n";
  darwinInit =
    # OPAM
    "[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null\n";
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
