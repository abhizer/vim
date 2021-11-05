local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Vinegar
    use 'tpope/vim-vinegar'

    -- Git Gutter
    use 'airblade/vim-gitgutter'

    -- NERDTree
    use 'scrooloose/nerdtree'

    -- Base 16 Colorscheme
    use 'chriskempson/base16-vim'
    use 'morhetz/gruvbox'

    -- Airline
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- Vim Surround
    use 'tpope/vim-surround'

    -- Tabular
    use 'godlygeek/tabular'

    -- Easy Comment Uncomment
    use 'tpope/vim-commentary'

    -- Git / Fugitive
    use 'tpope/vim-fugitive'

    -- Better Matching with %
    use 'andymass/vim-matchup'

    -- Change Directory to the Project Root
    use 'airblade/vim-rooter'

    -- Close Tags
    use 'alvan/vim-closetag'

    -- Sneak Search
    use 'justinmk/vim-sneak'

    -- Laravel Blade
    use 'jwalton512/vim-blade'

    -- Nginx
    use 'chr4/nginx.vim'

    -- GoLang
    use 'fatih/vim-go'

    -- Rust
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'

    -- TOML
    use 'cespare/vim-toml'

    -- Terraform
    use 'hashivim/vim-terraform'

    -- Fancy Start Page
    use 'mhinz/vim-startify'

    -- Nvim-LSP
    use 'neovim/nvim-lspconfig'

    -- Extensions to built-in LSP, for example, providing type inlay hints
    use 'nvim-lua/lsp_extensions.nvim'

    -- Autocompletion framework for built-in LSP
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'

    -- Snippet Engine
    use 'hrsh7th/vim-vsnip'

    -- Optional dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Github Copilot
    -- use 'github/copilot.vim'

    -- Debugging Rust
    use 'mfussenegger/nvim-dap'

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Devicons
    use 'ryanoasis/vim-devicons'

end)

