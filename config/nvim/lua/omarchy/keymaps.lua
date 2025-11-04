local M = {}

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.setup()
  -- Save and quit
  map("n", "<leader>w", "<cmd>w<cr>")
  map("n", "<leader>q", "<cmd>confirm q<cr>")
  map("n", "<leader>Q", "<cmd>confirm qall!<cr>")

  -- Window management
  map("n", "<leader>sv", "<C-w>v")
  map("n", "<leader>sh", "<C-w>s")
  map("n", "<leader>se", "<C-w>=")
  map("n", "<leader>sx", "<cmd>close<cr>")

  map("n", "<C-Up>", "<cmd>resize +2<cr>")
  map("n", "<C-Down>", "<cmd>resize -2<cr>")
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

  -- Buffers
  map("n", "<leader>bn", "<cmd>enew<cr>")
  map("n", "<leader>bd", "<cmd>bdelete<cr>")
  map("n", "<S-l>", "<cmd>bnext<cr>")
  map("n", "<S-h>", "<cmd>bprevious<cr>")

  -- Clear search highlight
  map("n", "<leader>h", "<cmd>nohlsearch<cr>")

  -- Telescope shortcuts
  local ok_telescope, telescope_builtin = pcall(require, "telescope.builtin")
  if ok_telescope then
    map("n", "<leader>ff", telescope_builtin.find_files)
    map("n", "<leader>fg", telescope_builtin.live_grep)
    map("n", "<leader>fb", telescope_builtin.buffers)
    map("n", "<leader>fh", telescope_builtin.help_tags)
  end

  -- ToggleTerm
  map({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm<cr>")

  -- Stay in visual mode when indenting
  map("v", "<", "<gv")
  map("v", ">", ">gv")

  -- Move selection up/down
  map("v", "J", ":m '>+1<cr>gv=gv")
  map("v", "K", ":m '<-2<cr>gv=gv")
end

return M
