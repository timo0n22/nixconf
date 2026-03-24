# Модуль для MacBook Air M2 (Apple Silicon)
# Требует: firmware в /boot/asahi/ (кладётся Asahi-установщиком)
{ pkgs, ... }: {

  hardware.asahi.enable = true;

  # Libinput — тачпад и клавиатура
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
    };
  };

  # PowerManagement — продление жизни батареи
  powerManagement = {
    enable            = true;
    cpuFreqGovernor   = "schedutil";
  };

  # TLP / power-profiles — на Apple Silicon лучше schedutil + asahi-pm
  services.power-profiles-daemon.enable = false;  # конфликтует с TLP
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC  = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
      WIFI_PWR_ON_BAT             = "off";   # wifi powersave уже отключён в net.nix
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
