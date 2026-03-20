{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "khncfooichmfjbepaaaebmommgaepoid"; } # Unhook YouTube
    ];
  };
}
