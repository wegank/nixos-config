{ pkgs, lib, host, ... }:

let
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  home = {
    packages = with pkgs; [
      # Nix
      nixpkgs-fmt
      rnix-lsp
    ];
  };

  programs = {
    vscode = {
      enable = isLinux;
      package = (pkgs.vscode-with-extensions.override {
        vscode = pkgs.vscodium;
        vscodeExtensions = (with pkgs.vscode-extensions; [
          # Markdown
          davidanson.vscode-markdownlint
          yzhang.markdown-all-in-one
          # Nix
          jnoortheen.nix-ide
          # Shell
          foxundermoon.shell-format
        ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # Org mode
          {
            publisher = "vscode-org-mode";
            name = "org-mode";
            version = "1.0.0";
            sha256 = "sha256-o9CIjMlYQQVRdtTlOp9BAVjqrfFIhhdvzlyhlcOv5rY=";
          }
        ];
      }).overrideAttrs (old: {
        inherit (pkgs.vscodium) pname version;
      });
      userSettings = {
        "terminal.integrated.fontFamily" =
          "'Meslo LG S for Powerline'";
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "update.mode" = "none";
        "diffEditor.ignoreTrimWhitespace" = false;
        "nix.enableLanguageServer" = true;
      };
    };
  };
}
