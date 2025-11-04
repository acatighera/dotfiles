local M = {}

function M.setup()
  local ok, catppuccin = pcall(require, "catppuccin")
  if ok then
    catppuccin.setup({
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        mason = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",
          colored_indent_levels = false,
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
    return
  end

  vim.cmd.colorscheme("habamax")
end

return M
