# System configuration.

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
      xkbOptions = "eurosign:e";
      xkbVariant = "intl";

      displayManager = {
        # Enable SDDM.
        sddm.enable = true;
        # Enable autologin.
        autoLogin.enable = true;
        autoLogin.user = "weijia";
      };
      # Enable the Plasme 5 desktop.
      desktopManager.plasma5.enable = true;
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
    mutableUsers = false;
    users.weijia = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      password = import ./password.nix;
    };
  };

  fonts = {
    # Install fonts.
    fonts = with pkgs; [
      noto-fonts-cjk
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ 
          "Noto Sans CJK SC" 
          "Noto Sans CJK TC" 
          "Noto Sans CJK JP" 
        ];
        monospace = [ 
          "Noto Sans CJK SC" 
          "Noto Sans CJK TC" 
          "Noto Sans CJK JP" 
        ];
      };
    };
  };

  programs = {
    # Enable SUID wrappers.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # Enable Oh my ZSH.
    zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };
  };

  environment.systemPackages = with pkgs; [
    chromium
  ];

  # NixOS release.
  system.stateVersion = "20.09";
}
