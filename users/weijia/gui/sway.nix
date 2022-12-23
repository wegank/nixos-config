{ pkgs, lib, ... }:

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

  home = {
    packages = with pkgs; [
      bemenu
      kanshi
      networkmanagerapplet
      mako
      swayidle
      swaylock
      wl-clipboard
      wofi
    ];
  };
}
