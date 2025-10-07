{
  lib,
  pkgs,
  isDarwin,
  ...
}:

let
  package = pkgs.vscode;
in
{
  programs = {
    vscode = {
      enable = true;
      package =
        (pkgs.vscode-with-extensions.override {
          vscode = package;
          vscodeExtensions =
            (with pkgs.vscode-extensions; [
              # French Language Pack
              ms-ceintl.vscode-language-pack-fr
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
            ])
            ++ lib.optionals isDarwin (
              with pkgs.vscode-extensions;
              [
                # Copilot
                github.copilot
                # OCaml
                ocamllabs.ocaml-platform
                # Python
                # ms-python.python
                ms-python.vscode-pylance
              ]
            )
            ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              # Wolfram
              {
                publisher = "WolframResearch";
                name = "wolfram";
                version = "2.0.1";
                sha256 = "sha256-6VwGQnsJNLlQ23H4ChSDBmIvWUIcF2NC/uqakqKVYd0=";
              }
            ];
        }).overrideAttrs
          (old: {
            inherit (package) pname version;
          });
      profiles.default.userSettings = {
        # C++
        "C_Cpp.default.cppStandard" = "c++23";
        "C_Cpp.default.includePath" =
          lib.optionals isDarwin [
            "/opt/homebrew/include/**"
          ]
          ++ [
            "\${workspaceFolder}/**"
          ];
        # Copilot
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = true;
        };
        "github.copilot.editor.enableAutoCompletions" = true;
        # Docker
        "docker.extension.enableComposeLanguageServer" = false;
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
        "terminal.integrated.commandsToSkipShell" = [ "language-julia.interrupt" ];
        # LaTeX
        "latex-workshop.formatting.latex" = "latexindent";
        "latex-workshop.latex.outDir" = "%TMPDIR%";
        "latex-workshop.view.pdf.viewer" = "tab";
        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
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
