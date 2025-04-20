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
            postFetch = ''
              rm -f "$out/README.md" "$out/Readme.md"
            '';
            hash = "sha256-RvUUYvPn7CLpSEPBgI6BhMXnA32jA6GCQQG/VYGNTu8=";
          };
        };
    };
    defaultEditor = true;
  };
}
