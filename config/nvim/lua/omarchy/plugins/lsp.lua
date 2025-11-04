local M = {}

local function on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  map("n", "gr", vim.lsp.buf.references, "Goto References")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format Buffer")
end

function M.setup()
  local mason_ok, mason = pcall(require, "mason")
  if mason_ok then
    mason.setup()
  end

  local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if mason_lsp_ok then
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "cssls",
        "html",
        "jsonls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "gopls",
      },
    })
  end

  local lsp_ok, lspconfig = pcall(require, "lspconfig")
  if not lsp_ok then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_lsp_ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    tsserver = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},
    cssls = {},
    html = {},
    jsonls = {},
    marksman = {},
  }

  for server, config in pairs(servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach
    lspconfig[server].setup(config)
  end
end

return M
