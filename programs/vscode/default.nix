{ inputs, pkgs, config, ... }:
let
  marketplace =
    inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  marketplace-release =
    inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release;
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode.fhs;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      extensions = (with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        eamodio.gitlens
        elixir-lsp.vscode-elixir-ls
        github.copilot
        github.copilot-chat
        github.vscode-github-actions
        github.vscode-pull-request-github
        golang.go
        ionide.ionide-fsharp
        jnoortheen.nix-ide
        ms-dotnettools.csdevkit
        ms-dotnettools.csharp
        ms-dotnettools.vscode-dotnet-runtime
        ms-python.debugpy
        ms-toolsai.jupyter
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        ms-vscode-remote.remote-containers
        ocamllabs.ocaml-platform
        redhat.java
        # rust-lang.rust-analyzer
        scala-lang.scala
        scalameta.metals
        shopify.ruby-lsp
        sswg.swift-lang
        tamasfe.even-better-toml
        # vadimcn.vscode-lldb
        vscjava.vscode-java-pack
      ]) ++ (with marketplace; [
        betterthantomorrow.calva
        meta.sapling-scm
        vscodevim.vim
      ]) ++ (with marketplace-release; [ ]);
      userSettings = {
        "editor.fontFamily" =
          "'${config.font.monospace.name}', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontLigatures" =
          "'calt', 'liga', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09','ss19', 'ss20'";
        "editor.semanticHighlighting.enabled" = true;
        "terminal.integrated.minimumContrastRatio" = 1;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "window.titleBarStyle" = "custom";
        "editor.fontSize" = 16;
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
        "window.zoomLevel" = 0.4;
        "vscode-neovim.neovimInitVimPaths.linux" =
          "/home/tarek/.config/vscode/init.lua";
        "files.watcherExclude" = {
          "**/.bloop" = true;
          "**/.metals" = true;
          "**/.ammonite" = true;
        };
        "cmake.showOptionsMovedNotification" = false;
        "editor.formatOnSave" = true;
        "terminal.integrated.enableMultiLinePasteWarning" = false;
        "sapling.isl.showInSidebar" = true;
        "C_Cpp.default.cppStandard" = "c++23";
        "calva.prettyPrintingOptions" = {
          "printEngine" = "pprint";
          "enabled" = true;
          "width" = 120;
          "maxLength" = 50;
        };
      };
    };
  };

  xdg.configFile."vscode" = {
    source = ./dotfiles;
    recursive = true;
  };
}
