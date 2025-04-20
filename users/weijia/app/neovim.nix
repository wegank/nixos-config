{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      package =
        with pkgs;
        vimPlugins.coc-nvim.overrideAttrs {
          version = "2025-04-06";
          src = fetchFromGitHub {
            owner = "neoclide";
            repo = "coc.nvim";
            rev = "341a73d9a4195f2a4c8056b5dc668564cc9914f5";
            hash = "sha256-SP3qQXgeIE90nY1RVvhWxv0CExVLy+8g1ZCBLEo8uOA=";
          };
        };
    };
    defaultEditor = true;
  };
}
