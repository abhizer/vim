-- Editor 
-- vim.g['gruvbox_material_background'] = 'hard'
-- vim.cmd('colorscheme gruvbox-material')

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
    transparent_background = false,
    term_colors = true,
    compile = {
        enabled = false,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
    },
    color_overrides = {},
    highlight_overrides = {},
    native_lsp = {
        enabled = true,
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
        },
    },
})

vim.cmd [[colorscheme catppuccin]]

-- vim.cmd([[
--     if !has("gui_running")
--         set t_Co=256
--     endif

--     let &t_ut=''
--     hi Normal guibg=NONE
--     hi NonText guibg=NONE

--     let base16colorspace=256
-- ]])

-- vim.opt.termguicolors = true
-- vim.opt.background = 'dark'
-- vim.g['gruvbox_contrast_dark'] = 'hard'
-- vim.cmd('colorscheme gruvbox')
vim.opt.syntax = 'on'
vim.opt.swapfile = false


vim.opt.compatible = false
vim.opt.modeline = false
vim.opt.showmode = false

vim.g.mapleader = ','

-- " Disable highlight white space after "[]".
vim.g.v_highlight_array_whitespace_error = 0

-- " Disable highlight white space around the communications operator that don't follow the standard style.
vim.g.v_highlight_chan_whitespace_error = 0

-- " Disable highlight instances of tabs following spaces.
vim.g.v_highlight_space_tab_error = 0

-- " Disable highlight trailing white space.
vim.g.v_highlight_trailing_whitespace_error = 0

-- " Disable highlight function calls.
vim.g.v_highlight_function_calls = 0

vim.g.v_highlight_fields = 0

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.encoding = 'utf-8'

HOME = os.getenv("HOME")
vim.opt.undodir = HOME .. '/.vim/undodir'

vim.opt.undofile = true
-- vim.opt.scrolloff = 7
vim.cmd('set scrolloff=7')

-- Completion Option
vim.opt.completeopt='menuone,noinsert,noselect'
vim.g['completion_matching_strategy_list'] = { 'exact', 'substring', 'fuzzy' }

-- GUI
vim.opt.ttyfast = true
-- vim.opt.vb = { t_vb = '' } -- No Beeps
vim.opt.foldenable = false
-- vim.opt.guioptions = '-T' -- No toolbars
vim.opt.lazyredraw = true -- Cache syntax highlight to improve relativenumber

-- vim.opt.shortmess+=c -- No |ins-menu-messages| for autocompletion
vim.cmd('set shortmess+=c')
vim.opt.colorcolumn = '100'

-- Show hidden characters
-- vim.opt.listchars = { nbsp:¬,extends:»,precedes:«,trail:•
vim.opt.hidden = true

-- Rust
vim.g['rustfmt_autosave'] = 1

-- Automatically write the file when switching buffers
-- vim.opt.autowriteall = true
vim.opt.autowrite = true

-- Autocomplete Matching
vim.opt.complete = '.,w,b,u'

-- filetype indent on
-- filetype plugin indent on

vim.opt.smartindent = true
vim.opt.autoindent = true

-- Line Wrapping 
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak= '▹'

-- Airline 
-- vim.g['airline_powerline_fonts'] = 1
-- vim.g['airline#extensions#tabline#enabled'] =1 
-- vim.g['airline_theme'] ='base16_gruvbox_dark_hard'
-- vim.g['airline_theme']='zenburn'

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- Split Management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- NERDTree 
vim.cmd('let NERDTreeHijackNetrw = 0')

-- Auto-Commands
vim.cmd([[
    augroup autosourcing
    autocmd! 
    autocmd BufWritePost ~/.config/nvim/init.lua source %
    augroup END
]])


-- cmp 
local cmp = require("cmp")
cmp.setup {
  sources = {
    -- Copilot Source
    { name = "copilot", group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "luasnip", group_index = 2 },
  },
}


local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
})
