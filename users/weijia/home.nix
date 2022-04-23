# Home configuration.

{ pkgs, lib, owner, host, ... }:

let
  isDesktop = (host.profile == "desktop");
  isLinux = lib.strings.hasSuffix "linux" host.platform;
in
{
  imports = lib.optionals isLinux [
    ./app/fcitx.nix
    ./gui/gtk.nix
    ./x11/xdg.nix
  ] ++ lib.optionals (isDesktop && isLinux) [
    ./gui/sway.nix
    ./app/vscodium.nix
    ./www/firefox.nix
    ./www/chromium.nix
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
      envExtra = lib.optionalString (!isLinux)
        "export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}\n";
    };
  };
}
