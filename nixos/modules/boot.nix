{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernel.sysctl."kernel.printk" = "3 3 3 3";
}
