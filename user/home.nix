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
      modifier = "Mod4";
      output = {
        "Virtual-1" = {
          mode = "--custom 1680x945@60Hz";
        };
      };
      terminal = "alacritty";
    };
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
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
      name = "breeze-dark";
      package = pkgs.breeze-icons;
    };
    theme = {
      name = "Breeze-Dark";
      package = pkgs.breeze-gtk;
    };
  };

  home.packages = with pkgs; [
    # Sway.
    kanshi
    networkmanagerapplet
    mako
    swaylock
    swayidle
    waybar
    wl-clipboard
    wofi

    # Theming.
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance

    # Userland.
    gitAndTools.gitFull
    gitAndTools.gh
    neofetch
  ];
  
  programs = {
    alacritty = {
      enable = true;
    };

    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # ublock origin.
      ];
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [ 
        bbenoist.Nix
      ];
      userSettings = {
        "terminal.integrated.fontFamily" =
          "'Meslo LG S for Powerline'";
        "git.enableSmartCommit" = true;
        "update.mode" = "none";
        "diffEditor.ignoreTrimWhitespace" = false;
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

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    udiskie = {
      enable = true;
    };
  };
}
