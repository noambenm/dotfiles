return {
  -- Highlight, edit, and navigate code
  -- NOTE: `main` branch is a rewrite (requires nvim 0.11+ and the `tree-sitter` CLI).
  --  Highlighting/indent are no longer modules; they are enabled per buffer below.
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- the plugin does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    ts.install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'hcl', 'yaml' }

    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the filetype here.
    local regex_fallback = { ruby = true }

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-setup', { clear = true }),
      callback = function(args)
        local buf, ft = args.buf, args.match
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        local function start()
          if not pcall(vim.treesitter.start, buf, lang) then
            return
          end
          if regex_fallback[ft] then
            vim.bo[buf].syntax = 'on'
          else
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end

        -- Autoinstall languages that are not installed
        if not vim.list_contains(ts.get_installed(), lang) and vim.list_contains(ts.get_available(), lang) then
          ts.install(lang):await(vim.schedule_wrap(function()
            if vim.api.nvim_buf_is_valid(buf) then
              start()
            end
          end))
          return
        end

        start()
      end,
    })
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects (use its `main` branch)
}
