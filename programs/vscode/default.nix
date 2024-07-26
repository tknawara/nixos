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
      vscodevim.vim
      ms-vscode.cpptools-extension-pack
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-themes
      shopify.ruby-lsp
      catppuccin.catppuccin-vsc
    ]) ++ (with marketplace-release; [ github.copilot-chat ]);
    userSettings = {
      "editor.fontFamily" =
        "'CaskaydiaMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 15;
      "terminal.integrated.fontSize" = 15;
      "vim.leader" = "<space>";
      "vim.useSystemClipboard" = true;
      "vim.hlsearch" = true;
      "vim.incsearch" = true;
      "vim.enableNeovim" = true;
      "vim.smartRelativeLine" = true;
      "vim.neovimUseConfigFile" = true;
      "vim.neovimConfigPath" = "/home/tarek/.config/vscode/init.lua";
      "vim.handleKeys" = { "<C-p>" = false; };
      "extensions.experimental.affinity" = {
        "vscodevim.vim" = 1;
        "asvetliakov.vscode-neovim" = 1;
      };
      "window.zoomLevel" = 0.1;
      "vscode-neovim.neovimInitVimPaths.linux" =
        "/home/tarek/.config/vscode/init.lua";
      "files.watcherExclude" = {
        "**/.bloop" = true;
        "**/.metals" = true;
        "**/.ammonite" = true;
      };
      "cmake.showOptionsMovedNotification" = false;
      "editor.formatOnSave" = true;
    };
  };

  xdg.configFile."vscode" = {
    source = ./dotfiles;
    recursive = true;
  };
}
