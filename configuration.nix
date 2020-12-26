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
      # Enable iBus.
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ 
        libpinyin
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
    extraConfig = "
      load-module 
      module-native-protocol-tcp 
      auth-ip-acl=127.0.0.1
    ";
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
        # Enable GDM.
        gdm.enable = true;
        # Enable autologin.
        autoLogin = {
          enable = true;
          user = "weijia";
        };
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
      extraGroups = [
        "wheel"
        "networkmanager" 
      ];
      initialPassword = "changeme";
      shell = pkgs.zsh;
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
    systemPackages = with pkgs; [
      qt5.qtwayland
    ];
  };

  # Enable the Sway tiling compositor.
  programs = {
    sway = {
      enable = true;
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
