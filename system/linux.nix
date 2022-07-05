{ lib, pkgs, owner, isDesktop, isMobile, isServer, ... }:

{
  imports = [
    ./app/gnupg.nix
    ./gnome/dconf.nix
    ./media/fontconfig.nix
    ./media/pipewire.nix
    ./net/cups.nix
    ./net/networkmanager.nix
  ] ++ lib.optionals isDesktop [
    ./app/waydroid.nix
    ./dev/android-tools.nix
    ./gui/sway.nix
    ./gnome/gdm.nix
    ./gnome/gnome.nix
  ] ++ lib.optionals isMobile [
    ./gui/phosh.nix
    ./net/openssh.nix
  ] ++ lib.optionals isServer [
    ./app/podman.nix
    ./app/qemu.nix
    ./app/vscode-server.nix
    ./dev/android-tools.nix
    ./net/openssh.nix
    ./net/xrdp.nix
    ./sys/zram.nix
    ./xfce/xfce.nix
    ./www/apache.nix
  ];

  # Use the latest Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set time zone.
  time.timeZone = "Europe/Paris";

  # Set hostname.
  networking.hostName = "workstation";

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

  # Set state version.
  system.stateVersion = "22.05";
}
