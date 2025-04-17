{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      package =
        with pkgs;
        vimPlugins.coc-nvim.overrideAttrs {
          version = "2025-04-15";
          src = fetchFromGitHub {
            owner = "neoclide";
            repo = "coc.nvim";
            rev = "55fda716adda510e638fb4588ccbc93249c2d8d1";
            hash = "sha256-DSzCpFsKsIOHaxLI1ub9lYelrOy9qm3qhtL37/ql5lA=";
          };
        };
    };
    defaultEditor = true;
  };
}
