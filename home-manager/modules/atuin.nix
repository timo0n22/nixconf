{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      auto_sync = false;
      update_check = false;
      style = "compact";
      filter_mode_shell_up_key_binding = "session";
    };
  };
}
