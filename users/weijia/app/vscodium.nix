{ pkgs, lib, host, ... }:

let
  isLinux = lib.strings.hasSuffix "linux" host.platform;
  package = if isLinux then pkgs.vscodium else pkgs.vscode;
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
      enable = true;
      package = (pkgs.vscode-with-extensions.override {
        vscode = package;
        vscodeExtensions = (with pkgs.vscode-extensions; [
          # LaTeX
          james-yu.latex-workshop
          # Markdown
          davidanson.vscode-markdownlint
          yzhang.markdown-all-in-one
          # Nix
          jnoortheen.nix-ide
          # OCaml
          ocamllabs.ocaml-platform
          # Python
          ms-python.python
          ms-python.vscode-pylance
          # Shell
          foxundermoon.shell-format
        ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # French Language Pack
          {
            publisher = "MS-CEINTL";
            name = "vscode-language-pack-fr";
            version = "1.67.0";
            sha256 = "sha256-+iZAPs8eLOMQQ0akR0/hmWHw3Py/3IaTOmwKEbaCZxA=";
          }
          # Org mode
          {
            publisher = "vscode-org-mode";
            name = "org-mode";
            version = "1.0.0";
            sha256 = "sha256-o9CIjMlYQQVRdtTlOp9BAVjqrfFIhhdvzlyhlcOv5rY=";
          }
          # Wolfram
          {
            publisher = "WolframResearch";
            name = "wolfram";
            version = "1.5.0";
            sha256 = "sha256-DZ73DhwkdqMeSq98Nr6Z6WGcu2js+U7O3nF6kV000sM=";
          }
        ];
      }).overrideAttrs (old: {
        inherit (package) pname version;
      });
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "nix.enableLanguageServer" = true;
        "terminal.integrated.fontFamily" =
          "'Meslo LG S for Powerline'";
        "update.mode" = "none";
        "editor.inlineSuggest.enabled" = true;
      };
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "vscode-extension-MS-python-vscode-pylance"
  ];
}
