{ lib, isDarwin, isDesktop, ... }:

let
  darwinEnv = ''
    . "$HOME/.cargo/env"
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels''${NIX_PATH:+:$NIX_PATH}
    export PATH=~/.npm-global/bin:$PATH
  '';

  darwinInit = ''
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/weijiawang/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/weijiawang/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/weijiawang/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/weijiawang/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
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
