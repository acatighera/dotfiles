local M = {}

function M.setup()
  local cmp_ok, cmp = pcall(require, "cmp")
  if not cmp_ok then
    return
  end

  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if luasnip_ok then
    luasnip.config.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })
    local vscode_ok, vscode_loader = pcall(require, "luasnip.loaders.from_vscode")
    if vscode_ok then
      vscode_loader.lazy_load()
    end
  end

  local mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip_ok and luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip_ok and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  })

  local lspkind_ok, lspkind = pcall(require, "lspkind")

  cmp.setup({
    snippet = {
      expand = function(args)
        if luasnip_ok then
          luasnip.lsp_expand(args.body)
        end
      end,
    },
    mapping = mapping,
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if lspkind_ok then
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" }) .. " "
        end
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snip]",
          buffer = "[Buf]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
    }, {
      { name = "buffer", keyword_length = 3 },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
  })

  local autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  if autopairs_ok then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return M
