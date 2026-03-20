{ inputs, ... }: {
  imports = [ inputs.niri-flake.nixosModules.niri ];

  programs.niri.enable = true;

  # XDG portals для Wayland (скриншоты, шаринг экрана)
  xdg.portal = {
    enable = true;
    extraPortals = [ ];
    config.niri.default = [ "gnome" "gtk" ];
  };
}
