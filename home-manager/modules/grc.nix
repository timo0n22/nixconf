# grc — цветной вывод для ~50 утилит: ping, nmap, gcc, make, diff, df и др.
{ pkgs, ... }: {
  home.packages = [ pkgs.grc ];

  programs.fish = {
    # Алиасы-обёртки grc для часто используемых команд
    shellAliases = {
      ping       = "grc --colour=auto ping";
      traceroute = "grc --colour=auto traceroute";
      make       = "grc --colour=auto make";
      gcc        = "grc --colour=auto gcc";
      diff       = "grc --colour=auto diff";
      df         = "grc --colour=auto df";
      netstat    = "grc --colour=auto netstat";
      # nmap уже крутой, grc добавляет цвет к выводу
      nmap       = "grc --colour=auto nmap";
      ifconfig   = "grc --colour=auto ifconfig";
    };

    # grc поставляется с fish-completions/интеграцией через grc.fish
    interactiveShellInit = ''
      # Подключаем grc fish-интеграцию если файл существует
      set -l grc_fish "${pkgs.grc}/share/fish/vendor_conf.d/grc.fish"
      if test -f $grc_fish
        source $grc_fish
      end
    '';
  };
}
