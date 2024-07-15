{ inputs, pkgs, ... }:
let
  marketplace =
    inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  marketplace-release =
    inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release;
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    enableExtensionUpdateCheck = true;
    package = pkgs.vscode.fhs;
    extensions = (with pkgs.vscode-extensions; [
      github.vscode-github-actions
      github.vscode-pull-request-github
      jnoortheen.nix-ide
      ms-python.python
      ms-python.debugpy
      rust-lang.rust-analyzer
      golang.go
      tamasfe.even-better-toml
      ms-vscode-remote.remote-containers
      eamodio.gitlens
      vadimcn.vscode-lldb
      ms-toolsai.jupyter
    ]) ++ (with marketplace; [
      github.copilot
      scalameta.metals
      scala-lang.scala
      sswg.swift-lang
      vknabel.vscode-apple-swift-format
      asvetliakov.vscode-neovim
      ms-vscode.cpptools-extension-pack
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-themes
    ]) ++ (with marketplace-release; [ github.copilot-chat ]);
  };

  xdg.configFile."vscode" = {
    source = ./dotfiles;
    recursive = true;
  };
}
