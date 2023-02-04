local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Vinegar
    use 'tpope/vim-vinegar'

    -- Colorschemes
    -- use 'chriskempson/base16-vim'
    -- use 'morhetz/gruvbox'
    -- use 'sainnhe/gruvbox-material'
    use 'catppuccin/nvim'

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

    -- Auto Pairs
    -- use 'jiangmiao/auto-pairs'

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
    -- use 'rust-lang/rust.vim'
    -- use 'simrat39/rust-tools.nvim'

    -- Vlang
    use "ollykel/v-vim"

    -- TOML
    use 'cespare/vim-toml'

    -- Terraform
    use 'hashivim/vim-terraform'

    -- Nvim-LSP
    use 'neovim/nvim-lspconfig'

    -- Extensions to built-in LSP, for example, providing type inlay hints
    use 'nvim-lua/lsp_extensions.nvim'

    -- Autocompletion framework for built-in LSP
    -- use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-vsnip'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-buffer'

    -- Snippet Engine
    -- use 'hrsh7th/vim-vsnip'

    -- Optional dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Git Gutter
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                numhl = true,
                current_line_blame = true,
            }
        end
    }

    -- Debugger
    use 'mfussenegger/nvim-dap'

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Devicons
    use 'kyazdani42/nvim-web-devicons'

    -- Lspkind
    use 'onsails/lspkind-nvim'

    -- Fancy Start Page
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.opts)
        end
    }

    -- NvimTree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require 'nvim-tree'.setup {} end
    }

    -- Lualine
    use {
        'nvim-lualine/lualine.nvim',
    }

    -- Bufferline
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }


    -- Emmet
    use 'mattn/emmet-vim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup(
            -- {
            -- suggestion = { enabled = false },
            -- panel = { enabled = false },
            -- }
            )
        end,
    }

    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup(
                {
                    method = "getCompletionsCycling",
                }
            )
        end
    }


    --     use {
    --         'Exafunction/codeium.vim',
    --         config = function()
    --           -- Change '<C-g>' here to any keycode you like.
    --           vim.keymap.set('i', '<C-g>', function ()
    --             return vim.fn['codeium#Accept']()
    --           end, { expr = true })
    --         end
    --       }

end)
