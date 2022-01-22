# Home configuration.

{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      gaps = {
        inner = 4;
        outer = 2;
      };
      input = {
        "*" = {
          xkb_layout = "fr";
          xkb_variant = "mac";
        };
      };
      menu = "bemenu-run";
      modifier = "Mod4";
      output = {
        "Virtual-1" = {
          mode = "1680x1050";
          scale = "1.1";
        };
      };
      terminal = "alacritty";
    };
    extraConfig = ''
      xwayland disable
    '';
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    xwayland = false;
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = "Noto Sans 10";
      package = pkgs.noto-fonts;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.gnome-themes-extra;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gnome.gnome-themes-extra;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
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
      # Sway.
      bemenu
      kanshi
      networkmanagerapplet
      mako
      swayidle
      swaylock
      wl-clipboard
      wofi
      # Theming.
      gsettings-desktop-schemas
      gtk-engine-murrine
      gtk_engines
      lxappearance
      # Userland.
      android-tools
      neofetch
      nixpkgs-fmt
      rnix-lsp
      parted
      # Custom.
      # (pkgs.callPackage ./aegisub/default.nix { })
    ];
    shellAliases = {
      "codium" = "codium --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
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
      package = (pkgs.chromium.override {
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      });
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
  /*
  services = {
    udiskie = {
      enable = true;
    };
  };
  */
}
