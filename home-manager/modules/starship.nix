{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = "$character";
      right_format = "$git_branch$git_metrics$golang$directory ";

      add_newline = false;

      character = {
        success_symbol = "[󰘧](bold green)";
        error_symbol   = "[󰘧](bold red)";
        format         = "$symbol ";
      };

      directory = {
        format            = "[ $path ]($style)";
        style             = "bg:#3c3836 fg:#ebdbb2";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        format = "[ $symbol$branch ]($style)";
        style  = "bg:#504945 fg:#fabd2f";
        symbol = " ";
      };

      git_metrics = {
        disabled             = false;
        only_nonzero_diffs   = true;
        added_style          = "bg:#504945 fg:#b8bb26";
        deleted_style        = "bg:#504945 fg:#cc241d";
        format               = "[+$added]($added_style)[-$deleted]($deleted_style) ";
      };

      golang = {
        format = "[ $symbol$version ]($style)";
        style  = "bg:#3c3836 fg:#83a598";
        symbol = " ";
      };

      hostname = {
        ssh_only   = true;
        format     = "[$ssh_symbol$hostname]($style) ";
        style      = "bold purple";
      };

      # Отключаем ненужное
      time.disabled     = true;
      battery.disabled  = true;
      package.disabled  = true;
      nodejs.disabled   = true;
      python.disabled   = true;
      rust.disabled     = true;
      java.disabled     = true;
      line_break.disabled = true;
    };
  };
}
