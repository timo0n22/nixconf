{ inputs, pkgs, ... }: {
  imports = [ inputs.niri-flake.homeModules.niri ];

  programs.niri = {
    enable = true;

    settings = {
      # MacBook Air M2 — нативное Retina разрешение
      # scale 2 = логические пиксели 1280x832
      outputs."eDP-1" = {
        scale = 2.0;
      };

      input = {
        keyboard = {
          xkb = {
            layout  = "us,ru";
            options = "grp:alt_shift_toggle";
          };
        };
        touchpad = {
          tap                = true;
          natural-scroll     = true;
          scroll-factor      = 0.3;
          click-method       = "clickfinger";
        };
        mouse.natural-scroll = false;
      };

      layout = {
        gaps = 12;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width = {};

        focus-ring = {
          width          = 4;
          active-color   = "#83a598";
          inactive-color = "#665c54";
        };

        border.off = true;

        # Отступ сверху под waybar (высота 32px при scale 2 = 16 логических)
        struts = {
          top    = 0;
          bottom = 0;
          left   = 0;
          right  = 0;
        };
      };

      # Запуск при старте
      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "wl-paste" "--type" "text"  "--watch" "cliphist" "store" ]; }
        { command = [ "wl-paste" "--type" "image" "--watch" "cliphist" "store" ]; }
        { command = [ "nm-applet" "--indicator" ]; }
      ];

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      animations = {
        workspace-switch.off    = true;
        window-open.off         = true;
        window-close.off        = true;
        horizontal-view-movement = {
          duration-ms = 200;
          easing      = "ease-out-cubic";
        };
      };

      cursor = {
        hide-when-typing      = true;
        hide-after-inactive-ms = 10000;
      };

      # Правила для окон
      window-rules = [
        {
          matches = [{ app-id = "^org\\.telegram\\.desktop$"; }];
          open-on-workspace = "5";
        }
        {
          matches = [{ app-id = "^vesktop$"; }];
          open-on-workspace = "5";
        }
        {
          matches = [{ app-id = "^obsidian$"; }];
          open-on-workspace = "3";
        }
        {
          matches = [{ app-id = "^mpv$"; }];
          open-floating = true;
        }
        {
          matches = [{ app-id = "^imv$"; }];
          open-floating = true;
        }
        {
          matches = [{ app-id = "^pavucontrol$"; }];
          open-floating       = true;
          default-column-width.fixed = 600;
        }
      ];

      binds = with { mod = "Mod"; } ; {
        # Подсказка горячих клавиш
        "${mod}+Shift+Slash".action.show-hotkey-overlay = {};

        # Приложения
        "${mod}+T".action.spawn    = [ "ghostty" ];
        "${mod}+D".action.spawn    = [ "fuzzel" ];
        "${mod}+E".action.spawn    = [ "ghostty" "-e" "yazi" ];
        "${mod}+B".action.spawn    = [ "firefox" ];

        # Скриншоты
        "Print".action.screenshot             = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window  = {};

        # Звук
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        };

        # Яркость
        "XF86MonBrightnessUp".action.spawn   = [ "brightnessctl" "s" "10%+" ];
        "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "s" "10%-" ];

        # Управление окнами
        "${mod}+Q".action.close-window = {};

        "${mod}+H".action.focus-column-left  = {};
        "${mod}+L".action.focus-column-right = {};
        "${mod}+J".action.focus-window-down  = {};
        "${mod}+K".action.focus-window-up    = {};

        "${mod}+Left".action.focus-column-left  = {};
        "${mod}+Right".action.focus-column-right = {};
        "${mod}+Down".action.focus-window-down   = {};
        "${mod}+Up".action.focus-window-up       = {};

        "${mod}+Ctrl+H".action.move-column-left  = {};
        "${mod}+Ctrl+L".action.move-column-right = {};
        "${mod}+Ctrl+J".action.move-window-down  = {};
        "${mod}+Ctrl+K".action.move-window-up    = {};

        "${mod}+Ctrl+Left".action.move-column-left  = {};
        "${mod}+Ctrl+Right".action.move-column-right = {};
        "${mod}+Ctrl+Down".action.move-window-down   = {};
        "${mod}+Ctrl+Up".action.move-window-up       = {};

        "${mod}+Home".action.focus-column-first      = {};
        "${mod}+End".action.focus-column-last        = {};
        "${mod}+Ctrl+Home".action.move-column-to-first = {};
        "${mod}+Ctrl+End".action.move-column-to-last   = {};

        # Ширина колонки
        "${mod}+R".action.switch-preset-column-width = {};
        "${mod}+F".action.maximize-column            = {};
        "${mod}+Shift+F".action.fullscreen-window    = {};
        "${mod}+C".action.center-column              = {};
        "${mod}+Minus".action.set-column-width       = "-10%";
        "${mod}+Equal".action.set-column-width       = "+10%";
        "${mod}+Shift+Minus".action.set-window-height = "-10%";
        "${mod}+Shift+Equal".action.set-window-height = "+10%";

        # Окна в/из колонки
        "${mod}+Comma".action.consume-window-into-column    = {};
        "${mod}+Period".action.expel-window-from-column     = {};
        "${mod}+BracketLeft".action.consume-or-expel-window-left  = {};
        "${mod}+BracketRight".action.consume-or-expel-window-right = {};

        # Воркспейсы
        "${mod}+U".action.focus-workspace-down         = {};
        "${mod}+I".action.focus-workspace-up           = {};
        "${mod}+Page_Down".action.focus-workspace-down = {};
        "${mod}+Page_Up".action.focus-workspace-up     = {};

        "${mod}+Ctrl+U".action.move-column-to-workspace-down = {};
        "${mod}+Ctrl+I".action.move-column-to-workspace-up   = {};

        "${mod}+1".action.focus-workspace = 1;
        "${mod}+2".action.focus-workspace = 2;
        "${mod}+3".action.focus-workspace = 3;
        "${mod}+4".action.focus-workspace = 4;
        "${mod}+5".action.focus-workspace = 5;
        "${mod}+6".action.focus-workspace = 6;
        "${mod}+7".action.focus-workspace = 7;
        "${mod}+8".action.focus-workspace = 8;
        "${mod}+9".action.focus-workspace = 9;

        "${mod}+Ctrl+1".action.move-column-to-workspace = 1;
        "${mod}+Ctrl+2".action.move-column-to-workspace = 2;
        "${mod}+Ctrl+3".action.move-column-to-workspace = 3;
        "${mod}+Ctrl+4".action.move-column-to-workspace = 4;
        "${mod}+Ctrl+5".action.move-column-to-workspace = 5;
        "${mod}+Ctrl+6".action.move-column-to-workspace = 6;
        "${mod}+Ctrl+7".action.move-column-to-workspace = 7;
        "${mod}+Ctrl+8".action.move-column-to-workspace = 8;
        "${mod}+Ctrl+9".action.move-column-to-workspace = 9;

        # Буфер обмена
        "${mod}+V".action.spawn = [
          "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        ];

        # Выход
        "${mod}+Shift+E".action.quit = {};
        "${mod}+Shift+P".action.power-off-monitors = {};
      };
    };
  };
}
