{ pkgs, config, ... }:
{
  programs.helix = {
    package = pkgs.helix;
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "gruvbox";

      keys.normal = {
        # Space+e — открыть yazi как файловый пикер
        space.e = "file_explorer_in_current_buffer_directory";
        space.E = [
          ":sh rm -f /tmp/hx-yazi-chooser"
          ":insert-output yazi %{buffer_name} --chooser-file=/tmp/hx-yazi-chooser"
          ":insert-output printf '\\x1b[?1049h\\x1b[?2004h' > /dev/tty"
          ":open %sh{cat /tmp/hx-yazi-chooser}"
          ":redraw"
        ];
      };

      editor = {
        line-number = "relative";
        rulers = [
          80
          120
        ];
        jump-label-alphabet = "hjklabcdefgimnopqrstuvwxyz";
        true-color = true;
        cursorline = true;
        color-modes = true;
        soft-wrap.enable = true;
        end-of-line-diagnostics = "hint";

        lsp = {
          display-inlay-hints = true;
        };

        inline-diagnostics = {
          cursor-line = "warning";
        };

        file-picker = {
          hidden = false; # показывать скрытые файлы
          git-ignore = true;
        };

        auto-save = {
          after-delay.timeout = 3000;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "╎";
        };

        clipboard-provider = "wayland";
      };
    };

    # Языки LSP
    languages = {
      language-server = {
        gopls = {
          command = "gopls";
          config = {
            "formatting.gofumpt" = true;
            "ui.completion.usePlaceholders" = true;
            "ui.semanticTokens" = true;
          };
        };
        nil = {
          command = "nil";
        };
        yaml-language-server = {
          command = "yaml-language-server";
          args = [ "--stdio" ];
        };
      };

      language = [
        {
          name = "go";
          language-servers = [ "gopls" ];
          formatter = {
            command = "gofmt";
          };
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = [ "nil" ];
          formatter = {
            command = "nixfmt";
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
        }
      ];
    };

    ignores = [
      ".git/"
      "target/"
      "node_modules/"
      "*.lock"
      "__pycache__/"
      ".direnv/"
      "result"
      "result-*"
    ];
  };
}
