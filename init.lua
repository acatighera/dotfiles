local root = debug.getinfo(1, "S").source:sub(2)
local root_dir = vim.fn.fnamemodify(root, ":p:h")
local omarchy_init = root_dir .. "/config/nvim/init.lua"

local ok, err = pcall(dofile, omarchy_init)
if not ok then
  vim.notify(("Failed to load Omarchy config (%s): %s"):format(omarchy_init, err), vim.log.levels.ERROR)
end
