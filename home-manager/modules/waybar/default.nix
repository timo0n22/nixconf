{
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        # При scale=2 на M2 Air: 48 логических пикселей = 96 физических.
        # Достаточно для иконок + короткого текста.
        width = 39;
        exclusive = true; # резервирует пространство слева, остальное — свободно

        # Вертикальная боковая панель:
        # top    — воркспейсы (сверху вниз)
        # center — пусто (чтобы bottom всегда прижимался вниз)
        # bottom — статусы
        modules-left = [ "niri/workspaces" ];
        modules-center = [ ];
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
            active = "●";
            default = "○";
          };
        };

        # niri/window убран из боковой панели — слишком узко для заголовка

        "niri/language" = {
          # Иконки вместо текста EN/RU — влезают в узкую панель
          format-en = "🇺🇸";
          format-ru = "🇷🇺";
          tooltip = true;
        };

        "pulseaudio" = {
          # Только иконка + громкость (короткий формат для вертикальной панели)
          format = "{icon}\n{volume}";
          format-muted = "󰝟\nmute";
          format-bluetooth = "󰂯\n{volume}";
          format-icons = {
            headphones = "󰋋";
            headset = "󰋎";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
          tooltip = false;
          scroll-step = 5;
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}\n{capacity}";
          format-charging = "󰂄\n{capacity}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip = false;
        };

        "clock" = {
          # Вертикально: часы на одной строке, минуты на другой
          format = "{:%H\n%M}";
          format-alt = "{:%H\n%M}";
          tooltip = true;
          tooltip-format = "{:%A, %d %B %Y}";
        };

        "tray" = {
          icon-size = 18;
          spacing = 4;
          show-passive-items = true;
        };
      };
    };
  };
}
