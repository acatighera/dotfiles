-- =========================
--  LAZY.NVIM INITIAL SETUP
-- =========================
-- Prepend lazy.nvim to runtime path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("lazy.nvim is not installed. Please clone it from GitHub.")
  return
end
vim.opt.rtp:prepend(lazypath)

-- =============
--  PLUGIN LIST
-- =============
require("lazy").setup({
  -- 1) ctrlp (Fuzzy file finder)
  { "kien/ctrlp.vim" },

  -- 2) Ruby & Rails
  { "vim-ruby/vim-ruby" },
  { "tpope/vim-rails" },
  { "tpope/vim-endwise" },
  { "tpope/vim-bundler" },

  -- 3) Go support
  { "fatih/vim-go" },

  -- 4) Copilot
  { "github/copilot.vim" },

  -- 5) Syntax/Linting
  { "scrooloose/syntastic" },
  { "w0rp/ale" }, -- Alternative linting/fixing

  -- 6) Git
  { "tpope/vim-fugitive" },

  -- 7) Status Line
  { "vim-airline/vim-airline" },

  -- 8) Miscellaneous Tpope plugins
  { "tpope/vim-vinegar" },
  { "tpope/vim-haml" },

  -- 9) Slim templates
  { "slim-template/vim-slim" },

  -- 10) JavaScript/TypeScript/Coffee
  { "kchmck/vim-coffee-script" },
  { "isruslan/vim-es6" },
  { "leafgarland/typescript-vim" },

  -- 11) CSV
  { "chrisbra/csv.vim" },

  -- 12) Silver Searcher integration
  { "rking/ag.vim" },

  -- 13) YouCompleteMe (Older completion engine)
  { "valloric/youcompleteme" }, -- If it requires building

  -- 14) Rust
  { "rust-lang/rust.vim" },
  -- rust-analyzer is typically used via LSP, but we'll keep your listing:
  { "rust-analyzer/rust-analyzer" },

  -- 15) WebAPI (dependency for certain plugins, e.g. Syntastic)
  { "mattn/webapi-vim" },

  -- 16) Tmux Navigator
  -- { "christoomey/vim-tmux-navigator" },

  -- 17) ChatGPT.nvim + dependencies
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim"
    }
  },
  -- 18)  smart splits + nav
  { 'mrjones2014/smart-splits.nvim',
    config = function()
      require("smart-splits").setup({})
      local smart_splits = require("smart-splits")
      vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
      vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
      vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
      vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)
    end
  },
})

-- =======================
--  NEOVIM BASIC SETTINGS
-- =======================
vim.opt.filetype = "on"        -- enable filetype detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

vim.opt.termguicolors = true
vim.opt.linespace = 1
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.laststatus = 2
vim.opt.encoding = "utf-8"

-- Append to 'wildignore'
vim.opt.wildignore:append({
  "*/tmp/*",
  "*.so",
  "*.swp",
  "*.zip",
  "*/.git/*",
  "*/public/*"
})

-- Remove 'preview' from 'completeopt'
vim.opt.completeopt:remove("preview")

-- Other preferences
vim.opt.compatible = false
vim.opt.ttyfast = true
vim.opt.lazyredraw = true
vim.opt.splitbelow = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.cmd("cnoreabbrev git Git")

-- Create an autocmd group (optional, but good practice)
local group = vim.api.nvim_create_augroup("MyNetrwFix", { clear = true })

-- Unmap <C-L> in netrw buffers
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "netrw",
  callback = function()
    vim.cmd("silent! unmap <buffer> <C-L>")
  end,
})

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {desc='Terminal -> Normal'})

vim.o.background = "dark"
vim.cmd.colorscheme "bubblegum-256-dark"

local transparency_groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "EndOfBuffer",
  "StatusLine",
  "StatusLineNC",
  "WinSeparator",
}

local function apply_transparency()
  for _, group in ipairs(transparency_groups) do
    vim.cmd(("highlight %s guibg=NONE ctermbg=NONE"):format(group))
  end
end

apply_transparency()

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_transparency,
})
