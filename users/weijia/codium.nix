{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nixpkgs-fmt
      rnix-lsp
    ];
  };

  programs = {
    vscode = {
      enable = true;
      package = (pkgs.vscode-with-extensions.override {
        vscode = pkgs.vscodium;
        vscodeExtensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];
      }).overrideAttrs (old: {
        inherit (pkgs.vscodium) pname version;
      });
      userSettings = {
        "terminal.integrated.fontFamily" =
          "'Meslo LG S for Powerline'";
        "git.enableSmartCommit" = true;
        "update.mode" = "none";
        "diffEditor.ignoreTrimWhitespace" = false;
        "nix.enableLanguageServer" = true;
      };
    };
  };
}
