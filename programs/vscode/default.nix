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
      ms-vscode.cmake-tools
      twxs.cmake
      rust-lang.rust-analyzer
      ms-vscode.cpptools-extension-pack
      golang.go
      tamasfe.even-better-toml
      ms-vscode-remote.remote-containers
      eamodio.gitlens
      vadimcn.vscode-lldb
    ]) ++ (with marketplace; [ github.copilot ])
      ++ (with marketplace-release; [ github.copilot-chat ]);
  };
}
