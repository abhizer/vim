-- Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--VIMRC
map('n', '<leader>ev', ':e $MYVIMRC<cr>', opts)

--NERDTree
map('n', '<leader>1', ':NERDTreeToggle<cr>', opts)

-- Copy to clipboard
map('n', '<leader>y', '"*y', opts)

-- Paste from clipboard
map('n', '<leader>p', '"*p', opts)

-- No arrow keys - use hjkl
map('n', '<up>', '<nop>', opts)
map('n', '<down>', '<nop>', opts)
map('i', '<up>', '<nop>', opts)
map('i', '<down>', '<nop>', opts)
map('i', '<left>', '<nop>', opts)
map('i', '<right>', '<nop>', opts)

-- Center the search results
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)

-- Switch Buffers with Left and Right
map('n', '<left>', ':bp<cr>', opts)
map('n', '<right>', ':bn<cr>', opts)

-- Remove Search Highlight
map('n', '<leader><space>', ':nohlsearch<cr>', opts)

-- Laravel Mappings 
map('n', '<leader>lr',':e routes/web.php<cr>', opts)
map('n', '<leader>lm', ':!php artisan make:', opts)
map('n', '<leader>lp', ':!php artisan', opts)
map('n', '<leader>lfc', ':e app/Http/Controllers/<cr>', opts)
map('n', '<leader>lfm', ':e app/Models<cr>', opts)
map('n', '<leader>lfv', ':e resources/views/<cr>', opts)
map('n', '<leader>la', ':e routes/api.php<cr>', opts)

-- Rust
map('n', '<leader>rm', ':e ./src/main.rs<cr>', opts)
map('n', '<leader>rl', ':e ./src/lib.rs<cr>', opts)
map('i', ';;', '<ESC>A;<ESC>', opts)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)

-- LSP Mappings

-- LSP Remaps
-- Code navigation shortcuts
map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
map('n', 'g0', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
map('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>', opts)
map('n', '<space>D', ':lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<space>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>a', ':lua vim.lsp.buf.code_action()<CR>', opts)
map('n', '<space>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
map('n', '<space>f', ':lua vim.lsp.buf.formatting()<CR>', opts)
map('n', '<space>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts) 

-- Goto previous/next diagnostic warning/error
map('n', 'g[', ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', 'g]', ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)

