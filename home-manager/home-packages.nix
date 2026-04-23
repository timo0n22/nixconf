{ pkgs, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    obsidian
    telegram-desktop
    vesktop
    mpv
    imv
    pavucontrol
    pwvucontrol

    bottom
    brightnessctl
    cliphist
    ffmpeg
    htop
    mediainfo
    microfetch
    networkmanagerapplet
    ntfs3g
    playerctl
    silicon
    swappy
    udisks2
    unzip
    wget
    wl-clipboard
    wl-screenrec
    xdg-utils
    yt-dlp
    zip
    libnotify
    swaybg
    swaylock
    swayidle

    go
    gopls
    golangci-lint
    delve
    gotools
    goreleaser

    nmap
    burpsuite
    sqlmap
    ffuf
    gobuster
    hydra
    john
    hashcat
    netcat-gnu
    curl
    yara

    nodejs
    python3
    gcc
    nix-output-monitor
    glib

    pkgs-unstable.ghostty
    pkgs-unstable.claude-code
    pkgs-unstable.zmk-studio
  ];
}
