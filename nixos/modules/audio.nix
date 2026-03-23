{
  security.rtkit.enable = true;
  services.pipewire = {
    enable       = true;
    alsa.enable  = true;
    # support32Bit убран: на aarch64 нет pkgsi686Linux, сломает сборку
    pulse.enable = true;
    jack.enable  = true;   # нужен для некоторых audio-приложений
  };
}
