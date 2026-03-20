{ pkgs, ... }: {
  home.packages = with pkgs; [
    go
    gopls
    golangci-lint
    delve
    gotools
    goreleaser
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    GOBIN  = "$HOME/go/bin";
  };
}
