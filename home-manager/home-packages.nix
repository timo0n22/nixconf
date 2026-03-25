{ pkgs, pkgs-unstable, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # ── Десктопные приложения ──────────────────────────────────────────────
    obsidian           # заметки markdown
    telegram-desktop   # Telegram
    vesktop            # Discord (Wayland)
    mpv                # видеоплеер
    imv                # просмотрщик изображений
    pavucontrol        # управление звуком GUI
    pwvucontrol        # pipewire volume control

    # ── CLI утилиты ────────────────────────────────────────────────────────
    bottom             # системный монитор (btm)
    brightnessctl      # яркость экрана
    cliphist           # история буфера обмена
    ffmpeg             # обработка видео/аудио
    # fzf — убран: управляется programs.fzf в modules/fzf.nix
    htop               # мониторинг процессов
    mediainfo          # инфо о медиафайлах
    microfetch         # минималистичный neofetch
    networkmanagerapplet # nm-applet в трее
    ntfs3g             # поддержка NTFS
    playerctl          # управление медиаплеером
    # ripgrep — убран: управляется programs.ripgrep в modules/ripgrep.nix
    silicon            # красивые скриншоты кода
    swappy             # редактор скриншотов
    udisks2            # CLI утилиты udisksctl (сервис включён в services.nix)
    unzip              # разархивирование
    wget               # скачивание файлов
    wl-clipboard       # буфер обмена Wayland
    wl-screenrec       # запись экрана для Wayland
    xdg-utils          # xdg-open и др.
    yt-dlp             # скачивание видео
    zip                # архивирование
    libnotify          # notify-send
    swaylock           # блокировка экрана (Wayland)
    swayidle           # автоблокировка по таймеру
    neovim

    # ── Go разработка ──────────────────────────────────────────────────────
    go
    gopls              # LSP
    golangci-lint      # линтер
    delve              # отладчик (dlv)
    gotools            # goimports, godoc и др.
    goreleaser         # релизы Go проектов

    # ── Security / TryHackMe / Bug bounty ─────────────────────────────────
    nmap
    # wireshark-qt — убран: programs.wireshark.enable = true в user.nix
    burpsuite
    sqlmap
    ffuf
    gobuster
    hydra
    john
    hashcat
    netcat-gnu
    curl
    yara               # анализ малвари / pattern matching (bug bounty / CTF)

    # ── Системные / разработка ─────────────────────────────────────────────
    nodejs
    python3
    # gnumake — убран: уже в local-packages.nix
    gcc
    nix-output-monitor  # красивый вывод nix build
    glib                # для уведомлений

    # unstable пакеты
    pkgs-unstable.ghostty
  ];
}
