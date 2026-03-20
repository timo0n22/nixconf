{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable   = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    targets = {
      helix.enable   = false;  # свой конфиг
      waybar.enable  = false;  # свой CSS
      firefox.enable = false;  # своя тема
    };

    cursor = {
      name    = "Adwaita";
      size    = 24;
      package = pkgs.adwaita-icon-theme;
    };

    fonts = {
      emoji = {
        name    = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name    = "FiraCode Nerd Font Mono";
        package = pkgs.nerd-fonts.fira-code;
      };
      sansSerif = {
        name    = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name    = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sizes = {
        terminal     = 12;
        applications = 11;
      };
    };

    iconTheme = {
      enable  = true;
      package = pkgs.papirus-icon-theme;
      dark    = "Papirus-Dark";
      light   = "Papirus-Light";
    };

    # Обои — можно заменить на свои
    image = pkgs.fetchurl {
      url    = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
      sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    };
  };

  # GTK тёмная тема
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  fonts.fontconfig.enable = true;
}
