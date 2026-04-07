{ ... }:
{
  xdg.configFile."ghostty/config" = {
    text = ''
      background = 000000
      background-opacity = 0.9
      keybind = performable:ctrl+c=copy_to_clipboard
      keybind = ctrl+v=paste_from_clipboard
    '';
  };
}
