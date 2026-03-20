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
    fzf                # fuzzy поиск
    htop               # мониторинг процессов
    mediainfo          # инфо о медиафайлах
    microfetch         # минималистичный neofetch
    networkmanagerapplet # nm-applet в трее
    ntfs3g             # поддержка NTFS
    playerctl          # управление медиаплеером
    ripgrep            # быстрый grep
    silicon            # красивые скриншоты кода
    swappy             # редактор скриншотов
    udisks2            # монтирование дисков
    unzip              # разархивирование
    wget               # скачивание файлов
    wl-clipboard       # буфер обмена Wayland
    wl-screenrec       # запись экрана для Wayland
    xdg-utils          # xdg-open и др.
    yt-dlp             # скачивание видео
    zip                # архивирование
    libnotify          # notify-send

    # ── Go разработка ──────────────────────────────────────────────────────
    go
    gopls              # LSP
    golangci-lint      # линтер
    delve              # отладчик (dlv)
    gotools            # goimports, godoc и др.
    goreleaser         # релизы Go проектов

    # ── Security / TryHackMe / Bug bounty ─────────────────────────────────
    nmap
    wireshark-qt
    burpsuite
    sqlmap
    ffuf
    gobuster
    hydra
    john
    hashcat
    netcat-gnu
    curl

    # ── Системные / разработка ─────────────────────────────────────────────
    nodejs
    python3
    gnumake
    gcc
    nix-output-monitor  # красивый вывод nix build
    glib                # для уведомлений

    # unstable пакеты
    pkgs-unstable.ghostty
  ];
}
