{ lib, pkgs, owner, isDesktop, isMobile, isServer, ... }:

{
  imports = [
    ./app/gnupg.nix
    ./app/vscode-server.nix
    ./dev/android-tools.nix
    ./gnome/dconf.nix
    ./media/fontconfig.nix
    ./media/pipewire.nix
    ./net/cups.nix
    ./net/networkmanager.nix
    ./net/openssh.nix
    ./sys/fwupd.nix
    ./sys/zram.nix
  ] ++ lib.optionals isDesktop [
    ./app/qemu.nix
    # ./app/waydroid.nix
    ./gnome/gdm.nix
    ./gnome/gnome.nix
    ./gui/sway.nix
  ] ++ lib.optionals isMobile [
    ./gui/phosh.nix
  ] ++ lib.optionals isServer [
    ./net/xrdp.nix
    ./xfce/xfce.nix
    ./www/nginx.nix
    ./www/nix-serve.nix
  ];

  # Use the latest Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set time zone.
  time.timeZone = if isServer then "Europe/Paris" else "Europe/Tallinn";

  # Set hostname.
  networking.hostName = if isServer then "server" else "workstation";

  # Set locale.
  i18n.defaultLocale = "fr_FR.UTF-8";
  services.xserver.layout = "fr";
  services.xserver.xkbVariant = "mac";
  console.useXkbConfig = true;

  # Define a user account.
  users.extraUsers.${owner.name} = {
    description = owner.fullName;
    isNormalUser = true;
    initialPassword = owner.initialPassword;
    openssh.authorizedKeys.keys = owner.authorizedKeys;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  # Install packages.
  environment.systemPackages = with pkgs; [
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

  # Remove packages.
  documentation.nixos.enable = false;
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Set state version.
  system.stateVersion = "22.05";
}
