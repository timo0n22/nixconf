{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [ "--height 40%" "--border" "--layout=reverse" ];
    colors = {
      bg      = "#282828";
      "bg+"   = "#3c3836";
      fg      = "#ebdbb2";
      "fg+"   = "#ebdbb2";
      hl      = "#fabd2f";
      "hl+"   = "#fabd2f";
      info    = "#83a598";
      prompt  = "#bdae93";
      spinner = "#fabd2f";
      pointer = "#83a598";
      marker  = "#fe8019";
      header  = "#665c54";
    };
  };
}
