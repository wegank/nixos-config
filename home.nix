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
          xkb_variant = "intl";
        };
      };
      modifier = "Mod4";
      terminal = "alacritty";
    };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      ibus-daemon -drx
    '';
    wrapperFeatures = {
      gtk = true;
    };
  };

  home.packages = with pkgs; [
    # Sway
    alacritty
    kanshi
    mako  # notification daemon.
    networkmanagerapplet
    swayidle
    swaylock  # lockscreen.
    waybar  # status bar.
    wl-clipboard
    wofi
    xwayland  # for legacy apps.

    neofetch
  ];
  
  programs = {
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
        "update.mode" = "none";
        "terminal.integrated.fontFamily" = "
          'Meslo LG S for Powerline'
        ";
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
  };
}
