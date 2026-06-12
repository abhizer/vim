vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.colorcolumn = '80'
vim.o.hlsearch = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.encoding = 'utf-8'

vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.updatetime = 150
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'
vim.g['completion_matching_strategy_list'] = { 'exact', 'substring', 'fuzzy' }

vim.cmd('set shortmess+=c')
vim.opt.hidden = true
-- NOTE: lazyredraw is intentionally NOT set. On modern Neovim it suppresses
-- redraws during autocmds, which makes redraw-on-CursorMoved plugins (e.g.
-- treesitter-context) leave the screen frozen/unhighlighted until a keypress.
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autowrite = true

vim.o.termguicolors = true
vim.o.scrolloff = 7

-- Treesitter folding is configured per-buffer in the nvim-treesitter (main)
-- FileType autocmd; open all folds when a file is read.
vim.cmd('autocmd BufReadPost,FileReadPost * normal zR')

-- Keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

-- Telescope
require('telescope').setup {
  defaults = {
    -- Telescope 0.1.4 uses nvim-treesitter's old configs/parsers API for
    -- preview buffers, which is not available on nvim-treesitter main.
    preview = {
      treesitter = false,
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Treesitter is configured on the nvim-treesitter `main` branch in
-- lua/plugins/init.lua (highlight/fold/indent autocmd + textobjects keymaps).
-- The old `require('nvim-treesitter.configs').setup{}` API does not exist on
-- the main branch. Note: incremental selection (<c-space>) was dropped — the
-- main branch has no module for it.
