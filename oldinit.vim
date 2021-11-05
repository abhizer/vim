" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Vinegar
Plug 'tpope/vim-vinegar'

" Git Gutter
Plug 'airblade/vim-gitgutter'

" NERDTree
Plug 'scrooloose/nerdtree'

" Base 16 Colorscheme
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Surround
Plug 'tpope/vim-surround'

" Tabular
Plug 'godlygeek/tabular'

" Easy Comment Uncomment
Plug 'tpope/vim-commentary'

" Git / Fugitive
Plug 'tpope/vim-fugitive'

" Better Matching with %
Plug 'andymass/vim-matchup'

" Change Directory to the Project Root
Plug 'airblade/vim-rooter'

" Close Tags
Plug 'alvan/vim-closetag'

" Sneak Search
Plug 'justinmk/vim-sneak'

" Laravel Blade
Plug 'jwalton512/vim-blade'

" Nginx
Plug 'chr4/nginx.vim'

" GoLang
Plug 'fatih/vim-go'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

" TOML
Plug 'cespare/vim-toml'

" Terraform
Plug 'hashivim/vim-terraform'

" Fancy Start Page
Plug 'mhinz/vim-startify'

" Nvim-LSP
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Snippet Engine
Plug 'hrsh7th/vim-vsnip'

" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Github Copilot
" Plug 'github/copilot.vim'

" Debugging Rust
Plug 'mfussenegger/nvim-dap'

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Devicons
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

if !has('gui_running')
    set t_Co=256
endif

set termguicolors

set background=dark
let base16colorspace=256
" colorscheme base16-gruvbox-dark-hard
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
let &t_ut=''
syntax on
hi Normal ctermbg=NONE
" highlight Normal guibg=none
" highlight NonText guibg=none
" Brighter comments
" call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
" call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")

" Editor 
set nocompatible
set nomodeline
let mapleader=','
set number
set relativenumber
set signcolumn=yes
set noshowmode

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set noswapfile 
set undodir=~/.vim/undodir
set undofile
set scrolloff=7

" Completion Option
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" GUI
set ttyfast
set vb t_vb= " No Beeps"
set nofoldenable
set guioptions=-T " No toolbars"
set lazyredraw " Cache syntax highlight to improve relativenumber"
set shortmess+=c " No |ins-menu-messages| for autocompletion"
set colorcolumn=100

" Show hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Rust 
let g:rustfmt_autosave = 1

" Automatically write the file when switching buffers
set autowriteall

" " Autocomplete Matching
set complete=.,w,b,u

filetype indent on
filetype plugin indent on
set smartindent

" Line Wrapping 
set wrap
set linebreak
set showbreak=▹

" Airline 
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled =1 
" let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_theme='zenburn'

" Search
set hlsearch
set incsearch
set smartcase
set gdefault

" Split Management
set splitbelow
set splitright

" NERDTree 
let NERDTreeHijackNetrw = 0

" Auto-Commands
augroup autosourcing
    autocmd! 
    autocmd BufWritePost ~/.config/nvim/init.vim source %
augroup END

" Mappings

"VIMRC
nmap <leader>ev :tabedit $MYVIMRC<cr>

"NERDTree
nmap <leader>1 :NERDTreeToggle<cr>

" Copy to clipboard
noremap <leader>y "*y

" Paste from clipboard
noremap <leader>p "*p

" No arrow keys - use hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop> 
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Center the search results
nnoremap n nzz
nnoremap N Nzz

" Switch Buffers with Left and Right
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" Remove Search Highlight
nmap <leader><space> :nohlsearch<cr>

" Laravel Mappings 
nmap <leader>lr :e routes/web.php<cr>
nmap <leader>lm :!php artisan make:
nmap <leader>lp :!php artisan
nmap <leader>lfc :e app/Http/Controllers/<cr>
nmap <leader>lfm :e app/Models<cr>
nmap <leader>lfv :e resources/views/<cr>
nmap <leader>la :e routes/api.php<cr>

" Rust
nmap <leader>rm :e ./src/main.rs<cr>
nmap <leader>rl :e ./src/lib.rs<cr>
imap ;; <ESC>A;<ESC>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

lua <<EOF
local nvim_lsp = require'lspconfig'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
        spacing = 4, 
        prefix = '←',
        },
    signs = true,
    update_in_insert = true,
    }
)

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = {"ccls"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end

  nvim_lsp = require "lspconfig"
  nvim_lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}

local opts = {
    tools = { -- rust-tools options
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler 
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },

            -- whether the hover action window gets automatically focused
            auto_focus = false
        },

        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true,
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = { -- rust-analyzer options
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
    -- debugging stuff
--    dap = {
--        adapter = {
--            type = 'executable',
--            command = 'lldb-vscode',
--            name = "rt_lldb"
--        }
--    }
}

require('rust-tools').setup(opts)

EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" TreeSitter based syntax highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = { "rust", "php", "go", "c", "cpp" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
 --   disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" LSP Remaps
" Code navigation shortcuts
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <space>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR> 

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
" set updatetime=150
set updatetime=50

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" TreeSitter based code folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
