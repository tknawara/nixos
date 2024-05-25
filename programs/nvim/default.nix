{ pkgs, inputs, config, ... }:

{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim 
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      mouse = "a";
    };

    plugins = {
      bufferline.enable = true;
      lualine.enable = true;
      oil.enable = true;

      treesitter = {
        enable = true;
        nixGrammars = true;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>lg" = "live_grep";
        };
      };

      cmp = { enable = true; };

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          bashls.enable = true;
          pyright.enable = true;
          lua-ls.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          clangd.enable = true;
        };
      };
    };

    colorschemes.kanagawa = {
      enable = true;
      settings = {
        background.dark = "dragon";
      };
    };

    extraPlugins = with pkgs.vimPlugins;
      [

      ];
  };
}
