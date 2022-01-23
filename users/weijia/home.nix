# Home configuration.

{ pkgs, lib, profile, ... }:

{
  imports = [
    ./gtk.nix
  ] ++ lib.optionals (profile == "desktop") [
    ./sway.nix
  ];

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  i18n = {
    inputMethod = {
      # Enable Fcitx.
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
      ];
    };
  };

  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      # Userland.
      android-tools
      neofetch
      nixpkgs-fmt
      rnix-lsp
      # Custom.
      # (pkgs.callPackage ./aegisub/default.nix { })
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      package = pkgs.alacritty.overrideAttrs (
        o: rec {
          doCheck = false;
        }
      );
    };

    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin.
      ];
    };

    firefox = {
      enable = true;
    };

    gh = {
      enable = true;
      enableGitCredentialHelper = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
        };
      };
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Weijia Wang";
      userEmail = "9713184+wegank@users.noreply.github.com";
    };

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

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = "agnoster";
      };
    };
  };
}
