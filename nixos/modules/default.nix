{
  imports = [
    ./apple-silicon.nix  # firmware WiFi/BT/audio, libinput, power
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./net.nix
    ./niri.nix
    ./nix.nix
    ./services.nix       # udisks2, gvfs, dconf, polkit, fonts
    ./smi-usb-display.nix  # Silicon Motion USB display (evdi + SMIUSBDisplayManager)
    ./timezone.nix
    ./v2raya.nix
    ./user.nix
    ./zram.nix
  ];
}
