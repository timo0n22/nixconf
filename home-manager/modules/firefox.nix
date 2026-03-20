{ firefox-addons, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      extensions.packages = with firefox-addons.packages.${pkgs.system}; [
        darkreader
        ublock-origin
        bitwarden
      ];

      settings = {
        "browser.startup.homepage"          = "about:blank";
        "browser.newtabpage.enabled"        = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "extensions.pocket.enabled"         = false;
        "browser.tabs.warnOnClose"          = false;
        "media.ffmpeg.vaapi.enabled"        = true;  # GPU ускорение
        "media.hardware-video-decoding.force-enabled" = true;
        "gfx.webrender.all"                 = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
