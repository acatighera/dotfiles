-- Omarchy Neovim entrypoint

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("omarchy.bootstrap").setup()
require("omarchy.options").setup()
require("omarchy.keymaps").setup()
require("omarchy.autocmds").setup()

local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
  lazy.setup(require("omarchy.plugins"), {
    defaults = {
      lazy = true,
      version = false,
    },
    install = {
      colorscheme = { "catppuccin", "tokyonight" },
    },
    checker = { enabled = false },
    change_detection = {
      enabled = true,
      notify = false,
    },
    ui = {
      border = "rounded",
    },
  })
else
  vim.notify("lazy.nvim is missing. Run :OmarchyInstallLazy", vim.log.levels.WARN)
end

require("omarchy.colors").setup()
