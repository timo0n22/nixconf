{ config, lib, ... }: {
  programs.fuzzel = {
    enable = true;
    settings.main = {
      font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=12";
      width = 40;
      lines = 12;
      terminal = "ghostty -e";
    };
  };
}
