{ pkgs, ... }: {
  services.v2raya = {
    enable = true;
    corePackage = pkgs.xray;
  };
}