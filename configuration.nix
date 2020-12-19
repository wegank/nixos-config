# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    inputMethod = {
      # Enable Fcitx.
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ libpinyin cloudpinyin ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  
  # Install fonts.
  fonts.fonts = with pkgs; [
    noto-fonts-cjk
  ];

  services = {
    xserver = {
      enable = true;
      # Configure keymap in X11.
      layout = "us";
      xkbOptions = "eurosign:e";

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
    glxinfo firefox
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
