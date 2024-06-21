{ pkgs, inputs, config, ... }:

{

  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    globals = { mapleader = " "; };

    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };

    opts = {
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      mouse = "a";
      smartindent = true;
    };

    plugins = {
      bufferline.enable = true;
      lualine.enable = true;
      oil.enable = true;
      lsp-format.enable = true;

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
            "<Tab>" = ''
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
        indent = true;
        nixGrammars = true;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>lg" = "live_grep";
        };
      };

      conform-nvim = {
        enable = true;
        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
        formattersByFt = {
          nix = [ "nixfmt" ];
          python = [ "isort" "black" ];
          lua = [ "stylua" ];
          markdown = [[ "prettierd" "prettier" ]];
        };
      };

      lsp = {
        enable = true;
        servers = {
          nil-ls.enable = true;
          pyright.enable = true;
          lua-ls.enable = true;
          sourcekit.enable = true;
          ruby-lsp.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          clangd.enable = true;
          jsonls.enable = true;
        };
        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "references";
          "gt" = "type_definition";
          "gi" = "implementation";
          "K" = "hover";
        };
        onAttach = ''
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
  };
}
