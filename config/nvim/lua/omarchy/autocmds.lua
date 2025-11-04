local M = {}

function M.setup()
  local augroup = vim.api.nvim_create_augroup("OmarchyAutoCommands", { clear = true })

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 })
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function(event)
      local file_dir = vim.fn.fnamemodify(event.match, ":p:h")
      if vim.fn.isdirectory(file_dir) == 0 then
        vim.fn.mkdir(file_dir, "p")
      end
    end,
  })
end

return M
