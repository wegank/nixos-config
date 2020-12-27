# Home configuration.

{ pkgs, ... }: 

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      gaps = {
        inner = 4;
        outer = 2;
      };
      modifier = "Mod4";
      startup = [
        {
          command = "fcitx -d";
          notification = false;
        }
      ];
      terminal = "alacritty";
    };
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
      package = pkgs.kdeFrameworks.breeze-icons;
    };
    theme = {
      name = "Breeze-Dark";
      package = pkgs.plasma5.breeze-gtk;
    };
  };

  home.packages = with pkgs; [
    # i3.
    dmenu
    i3lock
    i3blocks
    lxappearance
    networkmanagerapplet

    # userland.
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

    i3status = {
      enable = true;
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
    dunst = {
      enable = true;
    };

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
