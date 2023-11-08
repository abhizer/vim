-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- theme
  {
    'aktersnurra/no-clown-fiesta.nvim',
    config = function()
      require('no-clown-fiesta').setup({
        transparent = true,
        styles = {
          comments = { italic = true },
          type = { fg = "#9c8e72" , bold = true },
          lsp = { underline = true }
        }
      })
      vim.cmd.colorscheme 'no-clown-fiesta'
    end
  },
  -- Git in github
  'tpope/vim-fugitive',
  -- hub in github
  'tpope/vim-rhubarb',
  'tpope/vim-vinegar',
  'kyazdani42/nvim-web-devicons',
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer' },
  },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',          opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      numhl = true,
      current_line_blame = true,
      -- See `:help gitsigns.txt`
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
    },
  },
  {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.opts)
    end
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = function() require 'nvim-tree'.setup {} end
  },
  {
    -- theme
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        -- theme = "catppuccin",
        theme = "no-clown-fiesta",
        component_separators = "|",
        section_separators = '',
      }
    }
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  'nvim-lua/popup.nvim',
  'notjedi/nvim-rooter.lua',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function() require("bufferline").setup {} end,
  },
  {
    'onsails/lspkind-nvim',
    config = function()
      local lspkind = require("lspkind")
      lspkind.init({})
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  },

}, {})
