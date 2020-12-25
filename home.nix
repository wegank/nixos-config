# Home configuration.

{ pkgs, ... }: 

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      gaps = {
        inner = 4;
        outer = 2;
      };
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
