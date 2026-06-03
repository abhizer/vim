local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theme
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        theme = 'wave',
        background = {
          dark = 'wave',
          light = 'lotus',
        },
      })
      vim.cmd.colorscheme 'kanagawa-wave'
    end,
  },

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-vinegar',
  'kyazdani42/nvim-web-devicons',
  'tpope/vim-sleuth',

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'onsails/lspkind-nvim',
    },
  },

  -- UI
  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      numhl = true,
      current_line_blame = true,
    },
  },
  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.startify').opts)
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = function() require('nvim-tree').setup {} end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('plugins.lualine') end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '┊' },
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {
      options = {
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match('error') and ' ' or ' '
          return ' ' .. icon .. count
        end,
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
      },
    },
  },

  -- Search
  { 'nvim-telescope/telescope.nvim', version = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- Utilities
  'nvim-lua/popup.nvim',
  'notjedi/nvim-rooter.lua',
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },

  -- AI CLI agents (Claude + Codex) in identical floating terminals.
  -- Uses each tool's existing CLI auth, so no API keys are needed.
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({})

      local Terminal = require('toggleterm.terminal').Terminal

      -- Right-side floating window, matching the previous claude-code.nvim layout
      -- (44% wide, 95% tall, anchored to the right). row/col/size are functions so
      -- the float reflows when the editor is resized.
      local float_opts = {
        border = 'rounded',
        width = function() return math.floor(vim.o.columns * 0.44) end,
        height = function() return math.floor(vim.o.lines * 0.95) end,
        row = function() return math.floor(vim.o.lines * 0.02) end,
        col = function() return math.floor(vim.o.columns * 0.55) end,
      }

      local function new_agent(cmd)
        return Terminal:new({
          cmd = cmd,
          hidden = true,
          direction = 'float',
          float_opts = float_opts,
          on_open = function()
            vim.cmd('startinsert')
          end,
        })
      end

      local claude = new_agent('claude')
      local codex = new_agent('codex')

      -- Send the current visual selection to `term` as a formatted code block.
      -- The text is inserted into the prompt but NOT submitted, so it can be
      -- reviewed/edited before sending.
      local function send_selection(term)
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        local filename = vim.fn.expand('%:.')
        local ft = vim.bo.filetype ~= '' and vim.bo.filetype or 'text'
        local text = string.format('```%s\n# %s lines %d-%d\n%s\n```',
          ft, filename, start_line, end_line, table.concat(lines, '\n'))

        local function do_send()
          if term.job_id then
            vim.fn.chansend(term.job_id, text)
          end
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == term.bufnr then
              vim.api.nvim_set_current_win(win)
              vim.cmd('startinsert')
              return
            end
          end
        end

        if term:is_open() then
          do_send()
        else
          term:open()
          vim.defer_fn(do_send, 600)
        end
      end

      -- <leader>ac / <leader>ax are mode-aware: in normal/terminal mode they
      -- toggle the agent's float; in visual mode they send the selection.
      vim.keymap.set({ 'n', 't' }, '<leader>ac', function() claude:toggle() end,
        { desc = 'Toggle Claude' })
      vim.keymap.set('x', '<leader>ac', function() send_selection(claude) end,
        { desc = 'Send selection to Claude' })

      vim.keymap.set({ 'n', 't' }, '<leader>ax', function() codex:toggle() end,
        { desc = 'Toggle Codex' })
      vim.keymap.set('x', '<leader>ax', function() send_selection(codex) end,
        { desc = 'Send selection to Codex' })
    end,
  },
}, {})
