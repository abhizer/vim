set nocompatible              							"We want the latest vim settings.

so ~/.vim/plugins.vim

syntax enable
set backspace=indent,eol,start							"Make backspace behave like every other editor
let mapleader=','								"The default map leader is \, but comma is much better.
set number									"Enable line numbers

set noerrorbells visualbell t_vb=						"No damn bells.



"-----------Visuals-----------"
colorscheme gruvbox
set t_CO=256									"Use 256 colors. Useful for Terminal Vim.

set guifont=fira_code:h17							"Set the default font family and size.
"set macligatures								"We want pretty symbols, when available.
set linespace=0								"Mac-vim specific line-height.

set guioptions-=l								"Disable GUI scroll-bars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

set guioptions-=e								"We don't want GUI tabs

" Line wrapping
set nowrap
set linebreak
set showbreak=▹


"-----------Airline-----------"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'




"-----------Search-----------"
set hlsearch
set incsearch




"-----------Mappings-----------"

"Make it easy to edit the vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Make it easy to edit the plugins file.
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Make NERDTree easier to toggle.
nmap <Leader>1 :NERDTreeToggle<cr>

"Find something with ctags.
nmap <Leader>f :tag<space>




"-----------Split Management-----------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>




"-----------Search-----------"

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

nmap <D-p> :CtrlP<cr>
nmap <D-R> :CtrlPBufTag<cr>
nmap <D-E> :CtrlPMRUFiles<cr>


" Greplace.vim
set grepprg=ag										" Using ag for search

let g:grep_cmd_opts = '--line-numbers --no-heading'





" NERDTree

let NERDTreeHijackNetrw = 0

"-----------Auto-Commands-----------"
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

