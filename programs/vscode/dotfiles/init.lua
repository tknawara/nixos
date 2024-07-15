vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
    vim.keymap.set({ "n", "v" }, "y", [["+y]])
else
    -- ordinary Neovim
end
