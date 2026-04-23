{ pkgs, config, lib, ... }: let
  h = s: "#${s}";
  fgColor = config.lib.stylix.colors.base0D;
in {
  options.zjstatus = with config.lib.stylix.colors;
    lib.options.mkOption {
      type    = lib.types.lines;
      default = let
        bgColor = h base00;
        fg      = h fgColor;
      in ''
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            format_space   "#[bg=${bgColor}]"

            mode_normal    "#[bg=${fg},fg=${h base05}] {name} "
            mode_locked    "#[bg=${h base0B},fg=${bgColor}] {name} "

            tab_normal     "#[fg=${fg}] {name} "
            tab_active     "#[fg=${bgColor},bg=${fg}] {name} "

            format_left    "{tabs}"
            format_right   "#[fg=${fg},bg=${bgColor}] {session} {mode} "
          }
        }
      '';
    };

  config = {
    home.packages = [ pkgs.zellij pkgs.zjstatus ];

    home.file.".config/zellij/config.kdl".text = ''
      default_layout "default"
      default_shell "${config.programs.fish.package}/bin/fish"

      env {
        COLORTERM "truecolor"
      }

      mouse_mode false
      pane_frames false
      scrollback_editor "${config.programs.helix.package}/bin/hx"
      theme "gruvbox-dark"
      show_startup_tips false

      ui {
        pane_frames {
          hide_session_name true
        }
      }

      keybinds clear-defaults=true {
        locked {
          bind "F11" { SwitchToMode "normal"; }
        }
        pane {
          bind "h" { MoveFocus "left"; }
          bind "H" { MovePane "left"; }
          bind "j" { MoveFocus "down"; }
          bind "J" { MovePane "down"; }
          bind "k" { MoveFocus "up"; }
          bind "K" { MovePane "up"; }
          bind "l" { MoveFocus "right"; }
          bind "L" { MovePane "right"; }
          bind "d" { NewPane "down"; SwitchToMode "locked"; }
          bind "r" { NewPane "right"; SwitchToMode "locked"; }
          bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
          bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }
          bind "x" { CloseFocus; SwitchToMode "locked"; }
          bind "p" { SwitchToMode "normal"; }
          bind "tab" { SwitchFocus; }
        }
        tab {
          bind "h" "left"  { GoToPreviousTab; }
          bind "l" "right" { GoToNextTab; }
          bind "Shift h" "Shift left" { MoveTab "left"; }
          bind "Shift l" "Shift right" { MoveTab "right"; }
          bind "n"   { NewTab; SwitchToMode "locked"; }
          bind "x"   { CloseTab; SwitchToMode "locked"; }
          bind "r"   { SwitchToMode "renametab"; TabNameInput 0; }
          bind "t"   { SwitchToMode "normal"; }
          bind "tab" { ToggleTab; }
          bind "1"   { GoToTab 1; SwitchToMode "locked"; }
          bind "2"   { GoToTab 2; SwitchToMode "locked"; }
          bind "3"   { GoToTab 3; SwitchToMode "locked"; }
          bind "4"   { GoToTab 4; SwitchToMode "locked"; }
          bind "5"   { GoToTab 5; SwitchToMode "locked"; }
        }
        resize {
          bind "h" { Resize "Increase left"; }
          bind "j" { Resize "Increase down"; }
          bind "k" { Resize "Increase up"; }
          bind "l" { Resize "Increase right"; }
          bind "H" { Resize "Decrease left"; }
          bind "J" { Resize "Decrease down"; }
          bind "K" { Resize "Decrease up"; }
          bind "L" { Resize "Decrease right"; }
          bind "r" { SwitchToMode "normal"; }
        }
        scroll {
          bind "Ctrl u" { HalfPageScrollUp; }
          bind "Ctrl d" { HalfPageScrollDown; }
          bind "j"      { ScrollDown; }
          bind "k"      { ScrollUp; }
          bind "f"      { SwitchToMode "entersearch"; SearchInput 0; }
          bind "s"      { SwitchToMode "normal"; }
        }
        search {
          bind "n" { Search "down"; }
          bind "p" { Search "up"; }
          bind "c" { SearchToggleOption "CaseSensitivity"; }
          bind "w" { SearchToggleOption "Wrap"; }
        }
        session {
          bind "d" { Detach; }
          bind "o" { SwitchToMode "normal"; }
          bind "w" {
            LaunchOrFocusPlugin "session-manager" {
              floating true
              move_to_focused_tab true
            }
            SwitchToMode "locked"
          }
        }
        shared_among "normal" "locked" {
          bind "Alt h" "Alt left"  { MoveFocusOrTab "left"; }
          bind "Alt l" "Alt right" { MoveFocusOrTab "right"; }
          bind "Alt j" "Alt down"  { MoveFocus "down"; }
          bind "Alt k" "Alt up"    { MoveFocus "up"; }
          bind "Alt n"  { NewPane; }
          bind "Alt f"  { ToggleFloatingPanes; }
          bind "Alt +"  { Resize "Increase"; }
          bind "Alt -"  { Resize "Decrease"; }
        }
        normal {
          bind "/" { SwitchToMode "entersearch"; }
        }
        shared_except "locked" "renametab" "renamepane" {
          bind "Ctrl g" { SwitchToMode "locked"; }
          bind "Ctrl q" { Quit; }
        }
        shared_except "locked" "entersearch" {
          bind "enter" { SwitchToMode "locked"; }
        }
        shared_except "locked" "entersearch" "renametab" "renamepane" {
          bind "esc" { SwitchToMode "locked"; }
        }
        shared_except "locked" "entersearch" "renametab" "renamepane" "move" {
          bind "m" { SwitchToMode "move"; }
        }
        shared_except "locked" "tab" "entersearch" "renametab" "renamepane" {
          bind "t" { SwitchToMode "tab"; }
        }
        shared_except "locked" "tab" "scroll" "entersearch" "renametab" "renamepane" {
          bind "s" { SwitchToMode "scroll"; }
        }
        shared_among "normal" "resize" "tab" "scroll" "prompt" {
          bind "p" { SwitchToMode "pane"; }
        }
        shared_except "locked" "resize" "pane" "tab" "entersearch" "renametab" "renamepane" {
          bind "r" { SwitchToMode "resize"; }
        }
        shared_except "locked" "entersearch" "search" "renametab" "renamepane" "session" {
          bind "o" { SwitchToMode "session"; }
        }
        shared_among "scroll" "search" {
          bind "PageDown" "Ctrl f" { PageScrollDown; }
          bind "PageUp"  "Ctrl b" { PageScrollUp; }
          bind "Ctrl c"  { ScrollToBottom; SwitchToMode "locked"; }
          bind "d"       { HalfPageScrollDown; }
          bind "u"       { HalfPageScrollUp; }
        }
        entersearch {
          bind "Ctrl c" "esc" { SwitchToMode "scroll"; }
          bind "enter"        { SwitchToMode "search"; }
        }
        renametab   { bind "esc" { UndoRenameTab;  SwitchToMode "tab";  }; }
        renamepane  { bind "esc" { UndoRenamePane; SwitchToMode "pane"; }; }
        shared_among "renametab" "renamepane" {
          bind "Ctrl c" { SwitchToMode "locked"; }
        }
      }

      default_mode "locked"
      copy_command "wl-copy"
    '';

    home.file.".config/zellij/layouts/default.kdl".text = ''
      layout {
        default_tab_template {
          children
          ${config.zjstatus}
        }
      }
    '';
  };
}
