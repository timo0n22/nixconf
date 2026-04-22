{ lib, stdenv, fetchFromGitHub, autoPatchelfHook, libusb1, evdi }:

stdenv.mkDerivation {
  pname = "smi-usb-display";
  version = "4.3.6.0";

  src = fetchFromGitHub {
    owner = "georgedobreff";
    repo = "SiliconMotion-Driver-Fix";
    rev = "e81bf12b377d51abfa8e08eea6175ad64eaa6ce4";
    hash = "sha256-QG8C70/w8JjPYywooSE9HBX8pXzRYHjKI5Y1DoqsSr0=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  # libstdc++ и libgcc_s из stdenv, libevdi обрабатываем вручную через симлинк
  buildInputs = [ libusb1 stdenv.cc.cc.lib ];

  # evdi предоставляет libevdi.so с soname libevdi.so.1 — создаём симлинк вручную
  autoPatchelfIgnoreMissingDeps = [ "libevdi.so.1" ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib $out/share/smi-usb-display

    install -m755 aarch64/SMIUSBDisplayManager $out/bin/SMIUSBDisplayManager
    install -m755 ${./smi-udev.sh} $out/bin/smi-udev.sh
    install -m644 *.bin $out/share/smi-usb-display/

    # Симлинк libevdi.so.1 → реальная библиотека из evdi пакета
    ln -sf ${evdi}/lib/libevdi.so $out/lib/libevdi.so.1

    runHook postInstall
  '';

  postFixup = ''
    patchelf --add-rpath $out/lib $out/bin/SMIUSBDisplayManager
  '';

  meta = {
    description = "Silicon Motion SM77x USB display driver (userspace daemon)";
    homepage = "https://github.com/georgedobreff/SiliconMotion-Driver-Fix";
    platforms = [ "aarch64-linux" "x86_64-linux" ];
    license = lib.licenses.unfree;
  };
}
