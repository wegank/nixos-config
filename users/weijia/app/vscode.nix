{ lib, pkgs, isDarwin, ... }:

let
  package = pkgs.vscode;
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
          # Nix
          jnoortheen.nix-ide
          # Shell
          foxundermoon.shell-format
          # TOML
          tamasfe.even-better-toml
        ]) ++ lib.optionals isDarwin (with pkgs.vscode-extensions; [
          # Copilot
          github.copilot
          # OCaml
          ocamllabs.ocaml-platform
          # Python
          # ms-python.python
          ms-python.vscode-pylance
        ])
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # French Language Pack
          {
            publisher = "MS-CEINTL";
            name = "vscode-language-pack-fr";
            version = "1.90.2024061209";
            sha256 = "sha256-A/NcmyxEBUKhmItK0TePgVhJkOJWU0BDeKKCtPKL3GE=";
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
            version = "1.7.0";
            sha256 = "sha256-ArkYX/lRSgb+yEYVnmdSaol9VHdopE3tQ9aYUsOJL3I=";
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
        "github.copilot.editor.enableAutoCompletions" = true;
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
        # JavaScript
        "[javascript]" = {
          "editor.defaultFormatter" = "vscode.typescript-language-features";
        };
        "redhat.telemetry.enabled" = false;
        # Julia
        "julia.enableTelemetry" = false;
        "julia.symbolCacheDownload" = true;
        "terminal.integrated.commandsToSkipShell" = [
          "language-julia.interrupt"
        ];
        # LaTeX
        "latex-workshop.latex.outDir" = "%TMPDIR%";
        "latex-workshop.view.pdf.viewer" = "tab";
        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = { "command" = [ "nixfmt" ]; };
          };
        };
        # Org
        "[org]" = {
          "editor.fontFamily" = "Ubuntu Mono derivative Powerline";
          "editor.fontSize" = 14;
        };
        # Python
        "[python]" = {
          "editor.formatOnType" = true;
        };
        # Miscellaneous
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.suggestSelection" = "first";
        "editor.unicodeHighlight.allowedLocales" = {
          "ja" = true;
          "zh-hant" = true;
        };
        "terminal.integrated.fontFamily" = "Meslo LG S for Powerline";
        "remote.SSH.useLocalServer" = false;
        "update.mode" = if isDarwin then "default" else "none";
      };
    };
  };
}
