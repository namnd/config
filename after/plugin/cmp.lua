local has_cmp, cmp = pcall(require, "cmp")
local _, luasnip = pcall(require, "luasnip")
local _, lspkind = pcall(require, 'lspkind')

if not has_cmp then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  completion = {
    -- autocomplete = false,
  },
  preselect = cmp.PreselectMode.None,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'gh_authors' },
  }, {
    {
      name = 'buffer',
      option = {
        keyword_length = 5,
      },
    },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'text',
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[snip]",
        buffer = "[buf]",
        gh_authors = "[git]"
      },
    }),
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

require("luasnip.loaders.from_lua").load({ paths = os.getenv("HOME") .. "/.config/nvim/snippets" })
