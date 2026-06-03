# nvim

My personal Neovim configuration — Lua-based, managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Highlights

- **Theme:** [Kanagawa](https://github.com/rebelot/kanagawa.nvim) (Wave)
- **LSP:** `nvim-lspconfig` + `mason.nvim` for managing servers, with `fidget.nvim` progress and `neodev.nvim` for Lua/Neovim API
- **Completion:** `nvim-cmp` (LSP, path, buffer sources) with `lspkind` icons
- **Fuzzy finding:** `telescope.nvim` with `fzf-native`
- **Syntax & text objects:** `nvim-treesitter` (+ textobjects)
- **Git:** `vim-fugitive`, `vim-rhubarb`, `gitsigns.nvim` (inline blame + number highlights)
- **UI:** `lualine`, `bufferline`, `alpha-nvim` dashboard, `nvim-tree`, `indent-blankline`, `which-key`
- **AI agents:** Claude (`<leader>ac`) and Codex (`<leader>ax`) in floating terminals via `toggleterm.nvim` — toggle in normal mode, send the visual selection as a code block in visual mode

## Layout

```
init.lua              entry point — loads the modules below
lua/plugins/          lazy.nvim plugin specs (init.lua) + lualine config
lua/editor/           core editor options, telescope & treesitter setup
lua/lsp/              LSP server configuration
lua/mappings/         key mappings
colors/               extra colorschemes
```

## Install

```sh
git clone git@github.com:abhizer/vim.git ~/.config/nvim
nvim   # lazy.nvim bootstraps itself and installs plugins on first launch
```

Requires a recent Neovim, `git`, and `make` (for `fzf-native`). The leader key is `,`.

## History

- Moved from Vimscript to Lua — 5 Nov 2021
- Updated plugins, cleaned up configs and UI — 18 Jan 2022
- Switched plugin manager to lazy.nvim, Kanagawa theme, added in-editor AI agents
