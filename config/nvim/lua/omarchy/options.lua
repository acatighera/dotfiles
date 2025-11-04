local M = {}

function M.setup()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  local opt = vim.opt

  opt.number = true
  opt.relativenumber = true
  opt.cursorline = true
  opt.signcolumn = "yes"
  opt.scrolloff = 8
  opt.sidescrolloff = 8

  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.expandtab = true
  opt.smartindent = true

  opt.wrap = false
  opt.termguicolors = true
  opt.background = "dark"
  opt.updatetime = 200
  opt.timeoutlen = 400

  opt.splitbelow = true
  opt.splitright = true
  opt.swapfile = false
  opt.backup = false
  opt.undofile = true

  opt.clipboard = "unnamedplus"
  opt.completeopt = { "menu", "menuone", "noselect" }
  opt.list = true
  opt.listchars = {
    tab = "→ ",
    trail = "·",
    extends = "⟫",
    precedes = "⟪",
  }
end

return M
