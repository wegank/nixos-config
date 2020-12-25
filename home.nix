# Home configuration.

{ pkgs, ... }: 

{
  home.packages = with pkgs; [
    neofetch
    vscodium
  ];
  
  programs = {
    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # ublock origin
      ];
    };

    urxvt = {
      enable = true;
      fonts = [ "xft:Hack:size=9" ];
      extraConfig = {
        background = "black";
        foreground = "white";
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [ 
        bbenoist.Nix
      ];
    };

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = "agnoster";
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
