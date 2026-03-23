{ pkgs, user, ... }: {
  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      extraGroups  = [ "wheel" "networkmanager" "video" "audio" "wireshark" ];
    };
  };

  # Автологин на tty1 — niri стартует из fish
  services.getty.autologinUser = user;

  # wireshark без sudo
  programs.wireshark.enable = true;

  environment.sessionVariables = {
    # EDITOR/VISUAL не задаём здесь — helix.defaultEditor = true в home-manager
    GOPATH = "$HOME/go";
    GOBIN  = "$HOME/go/bin";
  };
}
