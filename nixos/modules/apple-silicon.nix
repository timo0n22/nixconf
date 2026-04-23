{ pkgs, ... }: {

  hardware.asahi.enable = true;

  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
    };
  };

  powerManagement = {
    enable            = true;
    cpuFreqGovernor   = "schedutil";
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC  = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
      WIFI_PWR_ON_BAT             = "off";
    };
  };

  systemd.services.battery-charge-threshold = {
    description   = "Set battery charge threshold to 80%";
    wantedBy      = [ "multi-user.target" ];
    after         = [ "multi-user.target" ];
    serviceConfig = {
      Type      = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/bin/sh -c 'echo 80 > /sys/class/power_supply/macsmc-battery/charge_control_end_threshold'";
    };
  };
}
