{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    gnumake
    cmake
    pkg-config
    binutils
    autoconf
    automake
    libtool
    usbutils
    pciutils
  ];
}
