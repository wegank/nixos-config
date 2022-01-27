# Home configuration.

{ pkgs, lib, owner, host, ... }:

{
  imports = [
    ./gtk.nix
  ] ++ lib.optionals (host.profile == "desktop") [
    ./codium.nix
    ./sway.nix
  ];

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  i18n = {
    inputMethod = {
      # Enable Fcitx.
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
      ];
    };
  };

  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      # Userland.
      android-tools
      gh
      neofetch
      # Custom.
      # (pkgs.callPackage ./aegisub/default.nix { })
    ];
  };

  programs = {
    alacritty = {
      enable = true;
    };

    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin.
      ];
    };

    firefox = {
      enable = true;
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = owner.fullName;
      userEmail = owner.gitEmail;
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
