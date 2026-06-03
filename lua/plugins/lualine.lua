local function lsp_server()
  local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
  local clients = get_clients({ bufnr = 0 })
  if #clients == 0 then return '' end
  local names = {}
  for _, client in ipairs(clients) do
    if client.name ~= 'null-ls' then
      table.insert(names, client.name)
    end
  end
  if #names == 0 then return '' end
  return ' ' .. table.concat(names, ', ')
end

require('lualine').setup {
  options = {
    theme = 'kanagawa',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
    disabled_filetypes = {
      statusline = { 'alpha', 'dashboard', 'NvimTree' },
    },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      { 'branch', icon = '' },
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
    },
    lualine_c = {
      {
        'filename',
        path = 1,
        symbols = { modified = '  ', readonly = ' ', unnamed = '' },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
      },
      lsp_server,
      { 'filetype', icon_only = false },
    },
    lualine_y = { 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}
