# System configuration.

{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot = {
    # Use the latest Linux kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
    };
  };

  # Set time zone.
  time.timeZone = "Europe/Paris";

  networking = {
    # Set hostname.
    hostName = "workstation";
    # Enable NetworkManager.
    networkmanager.enable = true;
    wireless.enable = false;
    # Enable DHCP.
    useDHCP = false;
    interfaces.enp0s5.useDHCP = true;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    inputMethod = {
      # Enable Fcitx.
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ 
        libpinyin
        cloudpinyin
      ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = 
      "load-module " +
      "module-native-protocol-tcp " + 
      "auth-ip-acl=127.0.0.1";
  };

  services = {
    xserver = {
      enable = true;
      # Configure keymap in X11.
      layout = "us";
      xkbVariant = "intl";
      displayManager = {
        lightdm.enable = true;
        # Enable autologin.
        autoLogin = {
          enable = true;
          user = "weijia";
        };
      };
      # Enable the i3 tiling window manager.
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      # Enable touchpad support.
      libinput.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;

    mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
          type "pulse"
          name "Pulseaudio"
          server "127.0.0.1"
        }
      '';
    };
  };

  # Define a user account.
  users = {
    users.weijia = {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "adbusers"
        "networkmanager" 
      ];
    };
  };

  fonts = {
    # Install fonts.
    fonts = with pkgs; [
      hack-font
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      powerline-fonts
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ 
          "Noto Sans CJK SC" 
          "Noto Sans CJK TC" 
          "Noto Sans CJK JP" 
        ];
      };
    };
  };

  environment = {
    pathsToLink = [
      "/libexec"
    ];
  };

  programs = {
    adb = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
  };
  
  # NixOS release.
  system.stateVersion = "20.09";
}
