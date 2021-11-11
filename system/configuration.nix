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
    useDHCP = false;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    inputMethod = {
      # Enable Fcitx.
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ 
        fcitx5-chinese-addons
      ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
  };
  
  services = {
    xserver = {
      enable = true;
      # Configure keymap in X11.
      layout = "us";
      xkbVariant = "intl";
      exportConfiguration = true;
      displayManager = {
        gdm.enable = true;
        # Enable autologin.
        autoLogin = {
          enable = true;
          user = "weijia";
        };
        defaultSession = "sway";
      };
      # Enable touchpad support.
      libinput.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
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
      font-awesome
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
    systemPackages = with pkgs; [
      git
    ];
  };

  programs = {
    # adb.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    sway.enable = true;
  };
  
  # NixOS release.
  system.stateVersion = "20.09";
}
