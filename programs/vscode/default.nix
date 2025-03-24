{ inputs, pkgs, config, ... }:
let
  marketplace =
    inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  marketplace-release =
    inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release;
in {
  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override (previous: {
      commandLineArgs = (previous.commandLineArgs or "")
        + " --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland --enable-wayland-ime --password-store=gnome --disable-gpu-sandbox";
    })).fhs;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = (with pkgs.vscode-extensions; [ ]) ++ (with marketplace; [
        eamodio.gitlens
        jnoortheen.nix-ide
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
        "vscode-neovim.neovimInitVimPaths.linux" =
          "/home/tarek/.config/vscode/init.lua";
        "files.watcherExclude" = {
          "**/.bloop" = true;
          "**/.metals" = true;
          "**/.ammonite" = true;
        };
        "cmake.showOptionsMovedNotification" = false;
        "editor.formatOnSave" = true;
        "terminal.integrated.enableMultiLinePasteWarning" = "never";
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "always";
          "source.fixAll" = "always";
        };
        "sapling.isl.showInSidebar" = true;
        "C_Cpp.default.cppStandard" = "c++23";
        "editor.smoothScrolling" = true;
        "d.dubCompiler" = "dmd";
        "d.dcdClientPath" = "/home/tarek/.local/share/code-d/bin/dcd-client";
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
