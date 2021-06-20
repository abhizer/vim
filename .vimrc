set nocompatible              							"We want the latest vim settings.


so ~/.vim/plugins.vim

let python_highlight_all=1
syntax enable
set backspace=indent,eol,start							"Make backspace behave like every other editor
let mapleader=','								"The default map leader is \, but comma is much better.
set number									"Enable line numbers

set noerrorbells visualbell t_vb=						"No damn bells.

"------Rust--------"
let g:rustfmt_autosave = 1



""-----------Visuals-----------"
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
set t_CO=256									"Use 256 colors. Useful for Terminal Vim.
set t_ut=
set termguicolors

set guifont=FuraCode\ Nerd\ Font:h17
set encoding=UTF-8

set background=dark
set linespace=0								"Mac-vim specific line-height.


set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4



set autowriteall                                                                "Automatically write the file when switching buffers."
set complete=.,w,b,u                                                            "Set our desired autocomplete matching."




filetype indent on
filetype plugin indent on
set smartindent


" Line wrapping
set wrap
set linebreak
set showbreak=▹

"-----------Airline-----------"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='zenburn'




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


" Laravel specific mappings
nmap <Leader>lr :e routes/web.php<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader>lp :!php artisan
nmap <Leader>lfc :e app/Http/Controllers/<cr>
nmap <Leader>lfm :e app/Models<cr>
nmap <Leader>lfv :e resources/views/<cr>
nmap <Leader>la :e routes/api.php<cr>



"" emmet expand
let g:user_emmet_leader_key='\'
let g:user_emmet_mode='a'                                                       "enable all function in all mode.





""-----------Split Management-----------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>




""-----------Search-----------"

"" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

nmap <D-p> :CtrlP<cr>
nmap <D-R> :CtrlPBufTag<cr>
nmap <D-E> :CtrlPMRUFiles<cr>


"" Greplace.vim
set grepprg=ag										" Using ag for search
let g:grep_cmd_opts = '--line-numbers --no-heading'



"" closetags
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.php, *.blade.php'



"" NERDTree

let NERDTreeHijackNetrw = 0


""-----------Scrolling-----------"








""-----------Auto-Commands-----------"
augroup autosourcing
	autocmd!
	autocmd BufWritePost ~/.vimrc source %
        autocmd BufRead,BufWritePre *.blade.php normal gg=G
augroup END


""-------Copy Paste-------"
nnoremap <D-v> a<C-r>+<Esc>
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+

"------ ALE -------"
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = ''
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'rust': ['rustfmt'],
\}

inoremap <silent><expr><TAB>
    \ pumvisible() ? “\<C-n>” : “\<TAB>”

nmap <silent> <leader>/. :ALEGoToDefinition<CR>
nmap <silent> <leader>/r :ALEFindReferences<CR>

nmap <silent> <leader>pe <Plug>(ale_previous_wrap)
nmap <silent> <leader>ne <Plug>(ale_next_wrap)
