local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "nvchad-config.configs.lspconfig"
    end,
  },

}

return plugins
