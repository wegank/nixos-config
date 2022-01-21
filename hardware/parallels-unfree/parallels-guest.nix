{ config, lib, pkgs, ... }:

with lib;

let
  prl-tools = config.hardware.parallels.package;
  aarch64 = pkgs.stdenv.hostPlatform.system == "aarch64-linux";
in

{

  options = {
    hardware.parallels = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          This enables Parallels Tools for Linux guests, along with provided
          video, mouse and other hardware drivers.
        '';
      };

      autoMountShares = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Control prlfsmountd service. When this service is running, shares can not be manually
          mounted through `mount -t prl_fs ...` as this service will remount and trample any set options.
          Recommended to enable for simple file sharing, but extended share use such as for code should
          disable this to manually mount shares.
        '';
      };

      package = mkOption {
        type = types.nullOr types.package;
        default = config.boot.kernelPackages.prl-tools;
        defaultText = "config.boot.kernelPackages.prl-tools";
        example = literalExpression "config.boot.kernelPackages.prl-tools";
        description = ''
          Defines which package to use for prl-tools. Override to change the version.
        '';
      };
    };

  };

  config = mkIf config.hardware.parallels.enable {

    services.udev.packages = [ prl-tools ];

    environment.systemPackages = [ prl-tools ];

    boot.extraModulePackages = [ prl-tools ];

    boot.kernelModules = [ "prl_fs" "prl_fs_freeze" "prl_tg" ] ++ optional aarch64 "prl_notifier";

    # services.timesyncd.enable = false;

    systemd.services.prltoolsd = {
      description = "Parallels Tools Service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${prl-tools}/bin/prltoolsd -f";
        PIDFile = "/var/run/prltoolsd.pid";
      };
    };

    systemd.services.prlfsmountd = mkIf config.hardware.parallels.autoMountShares {
      description = "Parallels Guest File System Sharing Tool";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = rec {
        ExecStart = "${prl-tools}/sbin/prlfsmountd ${PIDFile}";
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /media";
        ExecStopPost = "${prl-tools}/sbin/prlfsmountd -u";
        PIDFile = "/run/prlfsmountd.pid";
      };
    };

    systemd.services.prlshprint = {
      description = "Parallels Printing Tool";
      wantedBy = [ "multi-user.target" ];
      bindsTo = [ "cups.service" ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "${prl-tools}/bin/prlshprint";
      };
    };

    systemd.user.services = {
      prlcc = {
        description = "Parallels Control Center";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${prl-tools}/bin/prlcc";
        };
      };
      prldnd = {
        description = "Parallels Drag And Drop Tool";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${prl-tools}/bin/prldnd";
        };
      };
      prlcp = {
        description = "Parallels Copy Paste Tool";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${prl-tools}/bin/prlcp";
          Restart = "always";
        };
      };
      prlsga = {
        description = "Parallels Shared Guest Applications Tool";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${prl-tools}/bin/prlsga";
        };
      };
      prlshprof = {
        description = "Parallels Shared Profile Tool";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${prl-tools}/bin/prlshprof";
        };
      };
    };
  };
}
