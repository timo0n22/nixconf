{ config, pkgs, lib, ... }:

let
  pkg = pkgs.callPackage ../../pkgs/smi-usb-display {
    evdi = config.boot.kernelPackages.evdi;
  };
  startScript = pkgs.writeShellScript "smiusbdisplay-start" ''
    ${pkgs.kmod}/bin/modprobe evdi || exit 1
    ${pkg}/bin/SMIUSBDisplayManager &
    SMI_PID=$!
    for i in $(seq 30); do
      n=$(grep -l "^connected$" /sys/class/drm/*/status 2>/dev/null | grep -cv eDP)
      [ "$n" -ge 1 ] && break
      sleep 1
    done
    touch /run/smi-display-ready
    ${pkgs.systemd}/bin/systemd-notify --ready
    wait $SMI_PID
  '';
in {
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ];

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
    serviceConfig = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = startScript;
      ExecStopPost = "${pkgs.coreutils}/bin/rm -f /run/smi-display-ready";
      WorkingDirectory = "/opt/siliconmotion";
      Restart = "no";
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", \
     ATTR{idVendor}=="090c", IMPORT{builtin}="usb_id", \
     ATTR{bDeviceClass}=="ef", \
     ENV{SMIUSBDISPLAY_DEVNAME}="$env{DEVNAME}", \
     ENV{SMIUSBDISPLAY_DEVICE_ID}="$env{ID_BUS}-$env{BUSNUM}-$env{DEVNUM}-$env{ID_SERIAL}", \
     RUN+="${pkg}/bin/smi-udev.sh add $root $env{SMIUSBDISPLAY_DEVICE_ID} $env{SMIUSBDISPLAY_DEVNAME}", \
     RUN+="${pkgs.systemd}/bin/systemctl start smiusbdisplay.service"

    ACTION=="remove", ATTR{bDeviceClass}=="ef", \
     ENV{PRODUCT}=="90c/*", \
     RUN+="${pkg}/bin/smi-udev.sh remove $root $env{DEVNAME}", \
     RUN+="${pkgs.systemd}/bin/systemctl stop smiusbdisplay.service"
  '';
}
