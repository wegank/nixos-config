{ lib, pkgs, isDarwin, ... }:

let
  package = if isDarwin then pkgs.vscode else pkgs.vscodium;
in
{
  programs = {
    vscode = {
      enable = true;
      package = (pkgs.vscode-with-extensions.override {
        vscode = package;
        vscodeExtensions = (with pkgs.vscode-extensions; [
          # Jupyter
          ms-toolsai.jupyter
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
        ]) ++ lib.optional isDarwin (with pkgs.vscode-extensions; [
          # Copilot
          github.copilot
          # Python
          ms-python.python
          ms-python.vscode-pylance
        ])
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
        # C++
        "C_Cpp.default.cppStandard" = "c++20";
        # Copilot
        "github.copilot.enable" = {
          "*" = true;
          "yaml" = false;
          "plaintext" = false;
          "markdown" = false;
        };
        # Git
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        # Java
        "files.exclude" = {
          "**/.classpath" = true;
          "**/.project" = true;
          "**/.settings" = true;
          "**/.factorypath" = true;
        };
        "redhat.telemetry.enabled" = false;
        # LaTeX
        "latex-workshop.latex.outDir" = "%TMPDIR%";
        "latex-workshop.view.pdf.viewer" = "tab";
        # Markdown
        "[markdown]" = {
          "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        };
        # Nix
        "nix.enableLanguageServer" = true;
        # Miscellaneous
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.suggestSelection" = "first";
        "editor.unicodeHighlight.allowedLocales" = {
          "ja" = true;
          "zh-hant" = true;
        };
        "terminal.integrated.fontFamily" = "Meslo LG S for Powerline";
        "update.mode" = if isDarwin then "default" else "none";
      };
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "vscode-extension-github-copilot"
    "vscode-extension-MS-python-vscode-pylance"
  ];
}
