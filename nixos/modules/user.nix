{ pkgs, user, ... }: {
  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "wireshark" ];
    };
  };

  # Автологин на tty1 — niri стартует из fish
  services.getty.autologinUser = user;

  # wireshark без sudo
  programs.wireshark.enable = true;

  environment.sessionVariables = {
    EDITOR  = "hx";
    VISUAL  = "hx";
    GOPATH  = "$HOME/go";
    GOBIN   = "$HOME/go/bin";
  };
}
