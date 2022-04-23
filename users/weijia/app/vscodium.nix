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
        # Git
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        # LaTeX
        "latex-workshop.latex.outDir" = "%TMPDIR%";
        "latex-workshop.view.pdf.viewer" = "tab";
        # Nix
        "nix.enableLanguageServer" = true;
        # Miscellaneous
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.inlineSuggest.enabled" = true;
        "terminal.integrated.fontFamily" = "Meslo LG S for Powerline";
        "update.mode" = if isLinux then "none" else "default";
      };
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "vscode-extension-MS-python-vscode-pylance"
  ];
}
