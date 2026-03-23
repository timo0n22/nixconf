# Системные сервисы — dbus, монтирование, GTK, батарея
{ pkgs, ... }: {

  # udisks2 — монтирование USB/внешних дисков через dbus
  # (yazi, Thunar и др. используют его)
  services.udisks2.enable = true;

  # gvfs — trash, MTP, сетевые папки (нужен yazi и файловым менеджерам)
  services.gvfs.enable = true;

  # dconf — хранилище настроек GTK-приложений (pavucontrol, blueman и др.)
  programs.dconf.enable = true;

  # upower — события батареи через dbus (waybar battery module)
  services.upower.enable = true;

  # Полицит для разрешений (монтирование без sudo и т.п.)
  security.polkit.enable = true;
  # Агент polkit для Wayland (нужен для pkexec диалогов)
  systemd.user.services.polkit-agent = {
    description   = "Polkit authentication agent";
    wantedBy      = [ "graphical-session.target" ];
    after         = [ "graphical-session.target" ];
    serviceConfig = {
      Type      = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart   = "on-failure";
    };
  };

  # Системные шрифты
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig = {
      enable          = true;
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif     = [ "Noto Serif" ];
        emoji     = [ "Noto Color Emoji" ];
      };
    };
  };
}
