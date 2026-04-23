{ config, pkgs, lib, ... }:

let
  pkg = pkgs.callPackage ../../pkgs/smi-usb-display {
    evdi = config.boot.kernelPackages.evdi;
  };
  startScript = pkgs.writeShellScript "smiusbdisplay-start" ''
    ${pkg}/bin/SMIUSBDisplayManager &
    SMI_PID=$!
    for i in $(seq 10); do
      test -e /sys/class/drm/card1 && break
      sleep 1
    done
    ${pkgs.systemd}/bin/systemd-notify --ready
    wait $SMI_PID
  '';
in {
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ];
  boot.kernelModules = [ "evdi" ];

  system.activationScripts.smi-usb-display = ''
    mkdir -p /opt/siliconmotion
    for f in ${pkg}/share/smi-usb-display/*.bin; do
      ln -sf "$f" /opt/siliconmotion/
    done
    ln -sf ${pkg}/bin/smi-udev.sh /opt/siliconmotion/smi-udev.sh
  '';

  systemd.services.smiusbdisplay = {
    description = "Silicon Motion USB Display Manager";
    after = [ "systemd-udevd.service" ];
    before = [ "display-manager.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = startScript;
      WorkingDirectory = "/opt/siliconmotion";
      Restart = "always";
      RestartSec = 5;
    };
  };

  systemd.services.display-manager = {
    wants = [ "smiusbdisplay.service" ];
    after = [ "smiusbdisplay.service" ];
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", \
     ATTR{idVendor}=="090c", IMPORT{builtin}="usb_id", \
     ATTR{bDeviceClass}=="ef", \
     ENV{SMIUSBDISPLAY_DEVNAME}="$env{DEVNAME}", \
     ENV{SMIUSBDISPLAY_DEVICE_ID}="$env{ID_BUS}-$env{BUSNUM}-$env{DEVNUM}-$env{ID_SERIAL}", \
     RUN+="${pkg}/bin/smi-udev.sh add $root $env{SMIUSBDISPLAY_DEVICE_ID} $env{SMIUSBDISPLAY_DEVNAME}"

    ACTION=="remove", ATTR{bDeviceClass}=="ef", \
     ENV{PRODUCT}=="90c/*", RUN+="${pkg}/bin/smi-udev.sh remove $root $env{DEVNAME}"
  '';
}
