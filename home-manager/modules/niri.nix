{ inputs, pkgs, ... }:
{
  imports = [ inputs.niri-flake.homeModules.niri ];

  programs.niri = {
    enable = true;

    config = ''
      // MacBook Air M2 — Retina, scale 2
      output "eDP-1" {
        scale 1.5
      }

      input {
        keyboard {
          xkb {
            layout "us,ru"
            options "grp:win_space_toggle,caps:escape"
          }
        }
        touchpad {
          natural-scroll
          scroll-factor 0.3
          click-method "clickfinger"
        }
      }

      layer-rule {
        match namespace="^wallpaper$"
        place-within-backdrop true
      }

      layout {
        gaps 0
        center-focused-column "never"
        background-color "transparent"

        preset-column-widths {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
        }

        default-column-width {}

        focus-ring {
          width 0
          active-color "#83a598"
          inactive-color "#665c54"
        }

        border {
          off
        }
      }

      prefer-no-csd

      screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

      cursor {
        hide-when-typing
        hide-after-inactive-ms 10000
      }

      spawn-at-startup "waybar"
      spawn-at-startup "sh" "-c" "swayidle -w timeout 300 'swaylock -f -c 000000' timeout 600 'niri msg action power-off-monitors' before-sleep 'swaylock -f -c 000000'"
      spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
      spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"
      spawn-at-startup "nm-applet" "--indicator"
      spawn-at-startup "swaybg" "-m" "fill" "-i" "/home/timon/.local/share/wallpaper.png"

      window-rule {
        match app-id=r#"^org\.telegram\.desktop$"#
        geometry-corner-radius 0
        clip-to-geometry true
      }

      window-rule {
        match app-id="vesktop"
        open-on-workspace "5"
      }

      window-rule {
        match app-id="obsidian"
        open-on-workspace "3"
      }

      window-rule {
        match app-id="mpv"
        open-floating true
      }

      window-rule {
        match app-id="imv"
        open-floating true
      }

      window-rule {
        match app-id="pavucontrol"
        open-floating true
        default-column-width { fixed 600; }
      }

      binds {
        Mod+Shift+Slash { show-hotkey-overlay; }
        Mod+Shift+W { spawn "sh" "-c" "pkill -SIGUSR1 waybar"; }

        Mod+T { spawn "ghostty"; }
        Mod+D { spawn "fuzzel"; }
        Mod+E { spawn "ghostty" "-e" "yazi"; }
        Mod+B { spawn "firefox"; }

        Mod+Shift+4       { screenshot; }
        Mod+Shift+5 { screenshot-screen; }
        Mod+Shift+6   { screenshot-window; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86MonBrightnessUp   { spawn "brightnessctl" "s" "10%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "s" "10%-"; }

        Mod+Q { close-window; }

        Mod+H     { focus-column-left; }
        Mod+L     { focus-column-right; }
        Mod+U     { focus-window-down; }
        Mod+I     { focus-window-up; }
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }

        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+L     { move-column-right; }
        Mod+Ctrl+U     { move-window-down; }
        Mod+Ctrl+I     { move-window-up; }
        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }

        Mod+Home      { focus-column-first; }
        Mod+End       { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+R        { switch-preset-column-width; }
        Mod+F        { maximize-column; }
        Mod+Shift+F  { fullscreen-window; }
        Mod+C        { center-column; }
        Mod+Minus    { set-column-width "-10%"; }
        Mod+Equal    { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+Comma        { consume-window-into-column; }
        Mod+Period       { expel-window-from-column; }
        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+J          { focus-workspace-down; }
        Mod+K          { focus-workspace-up; }
        Mod+Page_Down  { focus-workspace-down; }
        Mod+Page_Up    { focus-workspace-up; }
        Mod+Ctrl+J     { move-column-to-workspace-down; }
        Mod+Ctrl+K     { move-column-to-workspace-up; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

        Mod+Shift+L { spawn "swaylock" "-f" "-c" "000000"; }

        Mod+Shift+E { quit; }
        Mod+Shift+P { power-off-monitors; }
      }
    '';
  };
}
