local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function install_lazy()
  vim.notify("Installing lazy.nvim …", vim.log.levels.INFO)
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
  local result = vim.fn.system(clone_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("lazy.nvim installation failed:\n" .. result, vim.log.levels.ERROR)
  else
    vim.notify("lazy.nvim installed successfully.", vim.log.levels.INFO)
  end
end

function M.setup()
  if not vim.loop.fs_stat(lazypath) then
    install_lazy()
  end

  vim.opt.rtp:prepend(lazypath)

  vim.api.nvim_create_user_command("OmarchyInstallLazy", function()
    if vim.loop.fs_stat(lazypath) then
      vim.notify("lazy.nvim already exists at " .. lazypath, vim.log.levels.INFO)
    else
      install_lazy()
      vim.opt.rtp:prepend(lazypath)
    end
  end, { desc = "Install lazy.nvim manually (for air-gapped setups)" })
end

return M
