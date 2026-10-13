-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Automatically turns .tf files into terraform files without restarting the editor.
vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

-- Polyfill for vim.lsp.codelens.enable missing in Neovim 0.11
if vim.lsp and vim.lsp.codelens and not vim.lsp.codelens.enable then
  vim.lsp.codelens.enable = function(enable, opts)
    if enable and vim.lsp.codelens.refresh then
      pcall(vim.lsp.codelens.refresh, opts)
    end
  end
end