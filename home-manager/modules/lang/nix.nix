{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil      # Nix LSP
    nixfmt-rfc-style  # форматтер
  ];
}
