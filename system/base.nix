# System configuration.

{ config, pkgs, owner, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  # Use the latest Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set time zone.
  time.timeZone = "Europe/Paris";

  networking = {
    # Set hostname.
    hostName = "workstation";
    # Enable NetworkManager.
    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  security = {
    rtkit.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = false;
    };
  };

  services = {
    # Enable the X server.
    xserver = {
      enable = true;
      # Configure keymap in X11.
      layout = "fr";
      xkbVariant = "mac";
      # Enable touchpad support.
      libinput.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    # Enable PipeWire.
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
    extraUsers.${owner.name} = {
      description = owner.fullName;
      isNormalUser = true;
      initialPassword = owner.initialPassword;
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
      cantarell-fonts
      hack-font
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      powerline-fonts
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Cantarell"
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
      # Tools to manipulate filesystems.
      dosfstools
      ms-sys
      mtools
      ntfsprogs
      parted
      testdisk
      # Some archiver tools.
      unzip
      zip
    ];
  };

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # NixOS release.
  system.stateVersion = "20.09";
}
