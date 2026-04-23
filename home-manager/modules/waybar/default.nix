{
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        width = 0;
        height = 28;

        modules-left = [ ];
        modules-center = [ ];
        modules-right = [
          "niri/language"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];

        "niri/language" = {
          format-en = "🇺🇸";
          format-ru = "🇷🇺";
          tooltip = true;
        };

        "pulseaudio" = {
          format = "{icon} {volume}";
          format-muted = "󰝟 mute";
          format-bluetooth = "󰂯 {volume}";
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
          format = "{icon} {capacity}";
          format-charging = "󰂄 {capacity}";
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
          format = "{:%H:%M}";
          format-alt = "{:%H:%M}";
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
