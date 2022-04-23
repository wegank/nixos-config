# Home configuration.

{ pkgs, lib, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  imports = lib.optionals isLinux [
    ./fcitx.nix
    ./gtk.nix
    ./xdg.nix
  ] ++ lib.optionals (isDesktop && isLinux) [
    ./sway.nix
    ./codium.nix
    ./www-client/firefox.nix
    ./www-client/chromium.nix
  ];

  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      # Userland.
      # android-tools
      git-filter-repo
      gh
      neofetch
      screen
      # Custom.
      # (pkgs.callPackage ./aegisub/default.nix { })
    ];
  };

  programs = {
    alacritty = {
      enable = true;
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = owner.fullName;
      userEmail = owner.gitEmail;
    };

    home-manager = {
      enable = true;
    };

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = (
          if host.profile == "desktop" then
            "agnoster"
          else
            "robbyrussell"
        );
      };
    };
  };
}
