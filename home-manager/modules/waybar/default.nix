{
  programs.waybar = {
    enable = true;
    style  = ./style.css;

    settings = {
      mainBar = {
        layer    = "top";
        position = "top";
        # Высота 32px. При scale=2 на M2 Air это 16 физических пикселей.
        # Waybar займёт боковые зоны у челки, центр (где камера) — пустой.
        height   = 32;
        # Убираем центральный модуль — там челка с камерой
        modules-left  = [ "niri/workspaces" "niri/window" ];
        modules-right = [
          "niri/language"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "○";
          };
        };

        "niri/window" = {
          format     = "{title}";
          max-length = 40;
        };

        "niri/language" = {
          format-en = "EN";
          format-ru = "RU";
          tooltip   = false;
        };

        "pulseaudio" = {
          format         = "{icon} {volume}%";
          format-muted   = " muted";
          format-bluetooth = " {volume}%";
          format-icons = {
            headphones = "";
            headset    = "";
            default    = [ "" "" ];
          };
          on-click = "pavucontrol";
          tooltip  = false;
        };

        "battery" = {
          states = { warning = 30; critical = 15; };
          format          = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons    = [ "" "" "" "" "" ];
          tooltip         = false;
        };

        "clock" = {
          format     = " {:%H:%M}";
          format-alt = " {:%d.%m.%Y}";
          tooltip    = false;
        };

        "tray" = {
          icon-size = 14;
          spacing   = 4;
        };
      };
    };
  };
}
