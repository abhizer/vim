-- Diagnostic keymaps
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<space>f', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, '[F]ormat buffer')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- gD is bound to lspeek's peek_definition (see lua/plugins/init.lua).
  nmap('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, { desc = 'Format current buffer' })

  -- Inlay hints (Neovim 0.11+): inferred types / param names shown inline.
  -- Enabled by default where supported, toggle with <leader>th.
  if client and client:supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    nmap('<leader>th', function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, '[T]oggle inlay [H]ints')
  end
end

local servers = {
  rust_analyzer = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      check = { command = 'clippy' },
      cargo = { allFeatures = true },
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim' } },
    },
  },
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Run on_attach via LspAttach autocommand. Passing on_attach through
-- vim.lsp.config('*') is not reliably invoked with mason-lspconfig's
-- automatic_enable path on 0.11+/0.12, which left the buffer-local keymaps
-- (gd, gr, K, ...) unset and made gd fall back to Neovim's built-in.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    on_attach(client, event.buf)
  end,
})

-- Apply global defaults to all servers (mason-lspconfig v2 / Neovim 0.11+ API)
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Apply per-server settings
for server_name, server_settings in pairs(servers) do
  vim.lsp.config(server_name, { settings = server_settings })
end

require('mason').setup()

-- automatic_enable = true (default) calls vim.lsp.enable() for each installed server
require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- Diagnostic signs
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = { prefix = '●' },
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-- Use rounded borders for all LSP floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      else fallback() end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 3 },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    }),
  },
}
