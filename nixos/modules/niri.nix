{ inputs, pkgs, ... }: {
  imports = [ inputs.niri-flake.nixosModules.niri ];

  programs.niri.enable = true;

  # XDG portals для Wayland (скриншоты, file picker, шаринг экрана)
  xdg.portal = {
    enable       = true;
    # gtk-portal нужен для file-picker (Firefox использует его через
    # widget.use-xdg-desktop-portal.file-picker = 1)
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # "gnome" убран — gnome-shell не установлен, вызовет ошибку
    config.niri.default = [ "gtk" ];
  };
}
