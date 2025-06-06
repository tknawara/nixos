{ pkgs, inputs, config, ... }:

{

  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      nofoldenable = true;
    };

    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      mouse = "a";
      smartindent = true;
      ignorecase = true;
      smartcase = true;
    };

    plugins = {
      # yazi.enable = true;
      web-devicons.enable = true;
      bufferline.enable = true;
      mini.enable = true;
      noice = { enable = true; };
      lualine.enable = true;
      zen-mode.enable = true;
      twilight.enable = true;
      oil.enable = true;
      comment.enable = true;
      lsp-format.enable = true;
      neo-tree.enable = true;
      gitsigns.enable = true;
      vim-surround.enable = true;
      todo-comments.enable = true;
      notify = {
        enable = true;
        settings = { background_color = "#000000"; };
      };
      trouble = { enable = true; };
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap-go.enable = true;
      dap-python.enable = true;
      dap = {
        enable = true;
        extensions = { };
      };

      nvim-autopairs = { enable = true; };

      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_document_symbol"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "luasnip"; }
            { name = "path"; }
          ];
          mapping = {
            "<Tab>" = # lua
              ''
                cmp.mapping(
                  function(fallback)
                    if cmp.visible() then
                      cmp.select_next_item()
                    elseif require("luasnip").expand_or_locally_jumpable() then
                      require("luasnip").expand_or_jump()
                    elseif has_words_before() then
                      cmp.complete()
                    else
                      fallback()
                    end
                  end,
                  {"i", "s"}
                )
              '';
          };
        };
      };

      cmp-nvim-lsp.enable = true;

      treesitter = {
        enable = true;
        nixGrammars = true;
        nixvimInjections = true;
        folding = false;
        settings = { indent.enable = true; };
      };
      treesitter-context.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>lg" = "live_grep";
        };
        extensions.fzf-native = {
          enable = true;
          settings = { fuzzy = true; };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatter_by_ft = {
            nix = [ "nixfmt" ];
            python = [ "isort" "black" ];
            lua = [ "stylua" ];
            markdown = [[ "prettierd" "prettier" ]];
            scala = [ "scalafmt" ];
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          fsautocomplete.enable = true;
          clojure_lsp.enable = true;
          cmake.enable = true;
          dockerls.enable = true;
          elixirls.enable = true;
          gopls.enable = true;
          java_language_server.enable = true;
          jsonls.enable = true;
          lua_ls.enable = true;
          metals.enable = true;
          nil_ls.enable = true;
          ols.enable = true;
          pyright.enable = true;
          ruby_lsp.enable = false;
          zls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "references";
          "gt" = "type_definition";
          "gi" = "implementation";
          "K" = "hover";
        };
        onAttach = # lua
          ''
            if client.supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          '';
      };
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "mocha";
        transparent_background = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins;
      [

      ];
    extraConfigLua = # lua
      ''
           local dap, dapui = require("dap"), require("dapui")
           dap.listeners.before.attach.dapui_config = function()
           	dapui.open()
           end
           dap.listeners.before.launch.dapui_config = function()
           	dapui.open()
           end
           dap.listeners.before.event_terminated.dapui_config = function()
           	dapui.close()
           end
           dap.listeners.before.event_exited.dapui_config = function()
           	dapui.close()
           end

          local dap = require('dap')
          dap.set_log_level('debug')

          local dap = require("dap")
          dap.adapters.gdb = {
              type = "executable",
              command = "gdb",
              args = { "-i", "dap" }
          }

          local dap = require('dap')

        -- key bindings for dap
        vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
        vim.keymap.set('n', '<S-F5>', function() require('dap').terminate() end)
        vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
        vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
        vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
        vim.keymap.set('n', '<Leader>dr', function() require('dap').restart() end)

        vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)

        vim.keymap.set('n', '<Leader>dor', function() require('dap').repl.open() end)
        vim.keymap.set('n', '<Leader>drl', function() require('dap').run_last() end)

        vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
          require('dap.ui.widgets').hover()
        end)

        vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
          require('dap.ui.widgets').preview()
        end)

        vim.keymap.set('n', '<Leader>df', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.frames)
        end)

        vim.keymap.set('n', '<Leader>ds', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end)


        vim.g.neovide_padding_top = 10
        vim.g.neovide_padding_bottom = 10
        vim.g.neovide_padding_right = 10
        vim.g.neovide_padding_left = 10
      '';
  };
}
