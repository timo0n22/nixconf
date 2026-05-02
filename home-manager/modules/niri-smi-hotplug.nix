{ config, pkgs, ... }:

let
  reloadScript = pkgs.writeShellScript "niri-smi-reload" ''
    sleep 2
    ${config.programs.niri.package}/bin/niri msg action reload-config 2>/dev/null || true
  '';
in {
  systemd.user.paths.niri-smi-hotplug = {
    Unit.Description = "Watch for SMI USB display readiness";
    Path.PathExists = "/run/smi-display-ready";
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.niri-smi-hotplug = {
    Unit.Description = "Reload niri config after SMI display ready";
    Service = {
      Type = "oneshot";
      ExecStart = "${reloadScript}";
    };
  };
}
