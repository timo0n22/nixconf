# Модуль для USB-дисплеев на чипах Silicon Motion (SM768/SM770)
# Использует evdi как kernel module + userspace демон SMIUSBDisplayManager
{ config, pkgs, lib, ... }:

let
  pkg = pkgs.callPackage ../../pkgs/smi-usb-display {
    evdi = config.boot.kernelPackages.evdi;
  };
in {
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ];
  boot.kernelModules = [ "evdi" ];

  # /opt/siliconmotion — рабочая директория демона (firmware + udev script)
  system.activationScripts.smi-usb-display = ''
    mkdir -p /opt/siliconmotion
    for f in ${pkg}/share/smi-usb-display/*.bin; do
      ln -sf "$f" /opt/siliconmotion/
    done
    ln -sf ${pkg}/bin/smi-udev.sh /opt/siliconmotion/smi-udev.sh
  '';

  systemd.services.smiusbdisplay = {
    description = "Silicon Motion USB Display Manager";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.kmod}/bin/modprobe evdi";
      ExecStart = "${pkg}/bin/SMIUSBDisplayManager";
      WorkingDirectory = "/opt/siliconmotion";
      Restart = "always";
      RestartSec = 5;
    };
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
