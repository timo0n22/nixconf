{ pkgs, user, ... }: {
  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      extraGroups  = [ "wheel" "networkmanager" "video" "audio" "wireshark" ];
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user    = "greeter";
      };
    };
  };

  # wireshark без sudo
  programs.wireshark.enable = true;

  environment.sessionVariables = {
    # EDITOR/VISUAL не задаём здесь — helix.defaultEditor = true в home-manager
    GOPATH = "$HOME/go";
    GOBIN  = "$HOME/go/bin";
  };
}
