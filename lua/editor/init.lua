-- Editor 
vim.cmd([[
    if !has("gui_running")
        set t_Co=256
    endif

    let &t_ut=''
    hi Normal ctermbg=NONE
    
    let base16colorspace=256
]])

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g['gruvbox_contrast_dark'] = 'hard'
vim.cmd('colorscheme gruvbox')
vim.opt.syntax = 'on'
vim.opt.swapfile = false


vim.opt.compatible = false
vim.opt.modeline = false
vim.opt.showmode = false

vim.g.mapleader = ','

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
vim.g['airline_powerline_fonts'] = 1
vim.g['airline#extensions#tabline#enabled'] =1 
-- vim.g['airline_theme'] ='base16_gruvbox_dark_hard'
vim.g['airline_theme']='zenburn'

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

