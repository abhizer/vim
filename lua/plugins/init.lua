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

  -- Peek LSP definitions in a floating window. gD overrides
  -- vim.lsp.buf.declaration (set in lua/lsp/init.lua) on purpose — both jump
  -- to definitions, and the float is nicer for a quick look.
  {
    'r4ppz/lspeek.nvim',
    -- close = '<Esc>' also handles Ctrl+[ — they are the same byte in a terminal.
    opts = { keymaps = { close = '<Esc>' } },
    keys = {
      -- The flag lets the WinEnter autocmd below recognise the float that lspeek
      -- is about to open (async, after the LSP reply) and add ',d' as a second
      -- close key — lspeek itself only supports one.
      { 'gD', function() vim.g._lspeek_opening = true; require('lspeek').peek_definition() end, desc = 'Peek Definition' },
      { 'gT', function() vim.g._lspeek_opening = true; require('lspeek').peek_type_definition() end, desc = 'Peek Type Definition' },
    },
    config = function(_, opts)
      require('lspeek').setup(opts)
      vim.api.nvim_create_autocmd('WinEnter', {
        group = vim.api.nvim_create_augroup('LspeekExtraClose', { clear = true }),
        callback = function(ev)
          if not vim.g._lspeek_opening then return end
          local win = vim.api.nvim_get_current_win()
          if vim.api.nvim_win_get_config(win).relative == '' then return end -- wait for the float
          vim.g._lspeek_opening = false
          vim.keymap.set('n', ',d', function() pcall(vim.api.nvim_win_close, win, true) end,
            { buffer = ev.buf, nowait = true, silent = true, desc = 'Close lspeek preview' })
          vim.api.nvim_create_autocmd('WinClosed', {
            pattern = tostring(win),
            once = true,
            callback = function() pcall(vim.keymap.del, 'n', ',d', { buffer = ev.buf }) end,
          })
        end,
      })
    end,
  },

  -- Format on save. Lua uses stylua; Rust and everything else fall back to
  -- the LSP formatter (rust_analyzer's rustfmt respects edition/rustfmt.toml).
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      default_format_opts = { lsp_format = 'fallback' },
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
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

  -- Auto-close brackets/quotes, integrated with nvim-cmp.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
      -- Add (…) after completing a function/method from nvim-cmp.
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- tpope-style surround: cs"' , ds( , ysiw]
  { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },

  -- UI
  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      numhl = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local function map(l, r, desc)
          vim.keymap.set('n', l, r, { buffer = bufnr, desc = desc })
        end
        map(']c', function() gs.nav_hunk('next') end, 'Next git hunk')
        map('[c', function() gs.nav_hunk('prev') end, 'Prev git hunk')
        map('<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
      end,
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

  -- Treesitter (main branch — required for Neovim 0.12; the classic master
  -- branch does not support 0.12 and crashes the highlighter).
  -- NOTE: the main branch compiles parsers with the tree-sitter CLI (>=0.26.1),
  -- which must be on PATH (install it via your Nix config). Without it you
  -- still get Vim's regex syntax highlighting, just not treesitter.
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'bash', 'c', 'cpp', 'go', 'lua', 'markdown', 'markdown_inline',
        'python', 'query', 'rust', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc',
      })

      -- Enable treesitter highlighting, folding and (experimental) indentation
      -- for any buffer whose language has an installed parser.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('ts_enable', { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          -- Only enable treesitter when a parser AND highlight query are
          -- installed; otherwise leave Vim's regex syntax highlighting on.
          -- (On the main branch, parsers/queries need the tree-sitter CLI.)
          if not vim.treesitter.query.get(lang, 'highlights') then return end
          if not pcall(vim.treesitter.start, args.buf, lang) then
            return
          end
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          if ft ~= 'python' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  -- Textobjects (main branch, matches nvim-treesitter main).
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require('nvim-treesitter-textobjects.select').select_textobject
      local move = require('nvim-treesitter-textobjects.move')

      -- Select (visual / operator-pending)
      local sel = {
        aa = '@parameter.outer', ia = '@parameter.inner',
        af = '@function.outer', ['if'] = '@function.inner',
        ac = '@class.outer', ic = '@class.inner',
      }
      for lhs, obj in pairs(sel) do
        vim.keymap.set({ 'x', 'o' }, lhs, function() select(obj, 'textobjects') end,
          { desc = 'TS select ' .. obj })
      end

      -- Move between functions/classes
      local moves = {
        { ']m', move.goto_next_start, '@function.outer' },
        { ']]', move.goto_next_start, '@class.outer' },
        { ']M', move.goto_next_end, '@function.outer' },
        { '][', move.goto_next_end, '@class.outer' },
        { '[m', move.goto_previous_start, '@function.outer' },
        { '[[', move.goto_previous_start, '@class.outer' },
        { '[M', move.goto_previous_end, '@function.outer' },
        { '[]', move.goto_previous_end, '@class.outer' },
      }
      for _, m in ipairs(moves) do
        vim.keymap.set({ 'n', 'x', 'o' }, m[1], function() m[2](m[3], 'textobjects') end,
          { desc = 'TS move ' .. m[3] })
      end
    end,
  },
  -- Sticky header showing the enclosing fn/impl/scope at the top of the window.
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { max_lines = 3 },
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

  -- Render LaTeX math as ASCII art (popup or inline virtual text).
  {
    'jbyuki/nabla.nvim',
    keys = {
      { '<leader>p', function() require('nabla').popup({ border = 'rounded' }) end, desc = 'Nabla: popup math' },
      { '<leader>tp', function() require('nabla').toggle_virt() end, desc = 'Nabla: toggle inline math' },
    },
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
