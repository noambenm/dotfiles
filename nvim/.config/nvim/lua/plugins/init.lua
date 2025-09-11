-- Basic plugin specifications
return {
  -- Detect tabstop and shiftwidth automatically
  'NMAC427/guess-indent.nvim',

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Highlight todo, notes, etc in comments  
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Import plugin modules
  { import = 'plugins.telescope' },
  { import = 'plugins.lsp' },
  { import = 'plugins.completion' },
  { import = 'plugins.formatting' },
  { import = 'plugins.ui' },
  { import = 'plugins.treesitter' },
}