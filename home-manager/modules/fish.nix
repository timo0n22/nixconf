{ pkgs, config, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      # Nix / система
      sw    = "sudo nixos-rebuild switch --flake ~/flake#macbook-m2 --impure | nom";
      hms   = "home-manager switch --flake ~/flake#timon";
      upd   = "sudo nixos-rebuild switch --flake ~/flake#macbook-m2 --upgrade | nom";
      clean = "sudo nix-collect-garbage --delete-older-than 14d";

      # Редактор
      v  = "hx";
      hx = "hx";

      # Файлы
      y  = "yazi";
      rd = "rm -rf";

      # Git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph";

      # Go
      gob = "go build ./...";
      got = "go test ./...";
      gor = "go run .";

      # Навигация
      ".."  = "cd ..";
      "..." = "cd ../..";

      # Утилиты
      cat = "bat";
      ls  = "eza";
      ll  = "eza -la";
      lt  = "eza --tree --level=2";
    };

    plugins = [
      { name = "gruvbox";        src = pkgs.fishPlugins.gruvbox.src; }
      { name = "humantime-fish"; src = pkgs.fishPlugins.humantime-fish.src; }
      { name = "plugin-git";     src = pkgs.fishPlugins.plugin-git.src; }
    ];

    interactiveShellInit = ''
      set fish_greeting
      set -gx PATH $PATH $HOME/go/bin $HOME/.local/bin

      if type -q theme_gruvbox
        theme_gruvbox dark medium
      end

      if status is-login && test "$XDG_VTNR" = "1"
        exec niri-session
      end
    '';
  };

  # Тема gruvbox для fish
  xdg.configFile."fish/themes/Gruvbox.theme" = {
    text = ''
      fish_color_normal ebdbb2
      fish_color_command 83a598
      fish_color_quote b8bb26
      fish_color_redirection ebdbb2
      fish_color_end fe8019
      fish_color_error cc241d
      fish_color_param d3869b
      fish_color_comment 928374
      fish_color_match --background=458588
      fish_color_selection --background=504945
      fish_color_search_match --background=504945
      fish_color_history_current --bold
      fish_color_operator b8bb26
      fish_color_escape 83a598
      fish_color_cwd b8bb26
      fish_color_valid_path --underline
      fish_color_autosuggestion 928374
      fish_color_user 83a598
      fish_color_host d3869b
      fish_color_cancel cc241d --reverse
      fish_pager_color_prefix 83a598
      fish_pager_color_progress 928374
      fish_pager_color_selected_background --background=504945
    '';
  };
}
