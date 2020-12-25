# System configuration.

{ config, pkgs, ... }:

{ 
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include Home Manager.
    <home-manager/nixos>
  ];

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
    # Disable wireless support.
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

  services = {
    xserver = {
      enable = true;
      # Configure keymap in X11.
      layout = "us";
      xkbVariant = "intl";

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        # Enable LightDM.
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
        extraPackages = with pkgs; [
          dmenu
          i3blocks
          i3lock
          i3status
          lxappearance
          networkmanagerapplet
          rxvt-unicode
        ];
      };

      # Enable touchpad support.
      libinput.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account.
  users = {
    users.weijia = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager" 
      ];
      initialPassword = "changeme";
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
    variables = {
      EDITOR = "urxvt";
    };
  };

  # Enable Home Manager.
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.weijia = import ./home.nix;
  };

  # NixOS release.
  system.stateVersion = "20.09";
}
