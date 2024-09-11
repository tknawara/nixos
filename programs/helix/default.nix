{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        true-color = true;
        line-number = "relative";
        color-modes = true;
        bufferline = "always";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        gutters = [ "diff" "diagnostics" "line-numbers" "spacer" ];

        statusline = {
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          display-signature-help-docs = true;
        };
      };
    };

    languages = {
      language-server = {
        rust-analyzer = {
          config = {
            checkOnSave.command = "clippy";
            cargo.features = "all";
            cargo.unsetTest = [ ];
          };
        };
        pyright = {
          command = "${pkgs.pyright}/bin/pyright-langserver";
          args = [ "--stdio" ];
          config = { };
        };
        nil.command = "${pkgs.nil}/bin/nil";
        bash-language-server = {
          command = "${pkgs.bash-language-server}/bin/bash-language-server";
          args = [ "start" ];
        };
        ucm = {
          command = "nc"; # or 'ncat' or 'netcat'
          args = [ "localhost" "5757" ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        }
        {
          name = "cpp";
          auto-format = true;
        }
        {
          name = "c";
          auto-format = true;
        }
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "clojure";
          auto-format = true;
        }
        {
          name = "scala";
          auto-format = true;
        }
        {
          name = "unison";
          scope = "source.unison";
          injection-regex = "unison";
          file-types = [ "u" ];
          shebangs = [ ];
          roots = [ ];
          auto-format = false;
          comment-token = "--";
          indent = {
            tab-width = 4;
            unit = "    ";
          };
          language-servers = [ "ucm" ];
        }
      ];
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
      };
    };

  };
}
