filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'skwp/greplace.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-surround'
Plugin 'tomnomnom/xoria256.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-commentary'
Plugin 'tmhedberg/matchit'
Plugin 'alvan/vim-closetag'
Plugin 'jiangmiao/auto-pairs'
Plugin 'yggdroot/indentline'
Plugin 'ervandew/supertab'
Plugin 'jwalton512/vim-blade'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'chr4/nginx.vim'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'hashivim/vim-terraform'
Plugin 'dense-analysis/ale'
Plugin 'mhinz/vim-startify'


Plugin 'ryanoasis/vim-devicons'



call vundle#end()		" required
filetype plugin indent on	" required
