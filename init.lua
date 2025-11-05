vim.opt.termguicolors = true

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
