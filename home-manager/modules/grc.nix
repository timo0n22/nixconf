{ pkgs, ... }:
{
  home.packages = [ pkgs.grc ];

  programs.fish = {
    shellAliases = {
      ping = "grc --colour=auto ping";
      traceroute = "grc --colour=auto traceroute";
      make = "grc --colour=auto make";
      gcc = "grc --colour=auto gcc";
      diff = "grc --colour=auto diff";
      df = "grc --colour=auto df";
      netstat = "grc --colour=auto netstat";
      nmap = "grc --colour=auto nmap";
      ifconfig = "grc --colour=auto ifconfig";
    };

    interactiveShellInit = ''
      set -l grc_fish "${pkgs.grc}/share/fish/vendor_conf.d/grc.fish"
      if test -f $grc_fish
        source $grc_fish
      end
    '';
  };
}
