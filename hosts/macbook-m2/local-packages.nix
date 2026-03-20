{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # base-devel аналог
    gnumake
    cmake
    pkg-config
    binutils
    autoconf
    automake
    libtool
    # Apple Silicon утилиты
    usbutils
    pciutils
  ];
}
