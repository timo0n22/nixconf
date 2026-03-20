{
  programs.git = {
    enable = true;
    userName  = "timo0n22";          # <-- замени
    userEmail = "akkdlyaandroid@gmail.com"; # <-- замени
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase        = false;
      push.autoSetupRemote = true;
    };
  };
}
