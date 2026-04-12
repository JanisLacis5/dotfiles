-- Completion engine configuration
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require('cmp')
local has_luasnip, luasnip = pcall(require, 'luasnip')

if has_luasnip then
  -- Load VSCode-style snippets if available (e.g. friendly-snippets)
  pcall(function() require('luasnip.loaders.from_vscode').lazy_load() end)
end

local mapping = {
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-Space>'] = cmp.mapping.complete(),

  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif has_luasnip and luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end, { 'i', 's' }),

  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif has_luasnip and luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
}

local sources = {
  { name = 'nvim_lsp' },
}
if has_luasnip then table.insert(sources, { name = 'luasnip' }) end

cmp.setup({
  mapping = mapping,
  sources = sources,
})


-- local cmp = require("cmp")
--
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       -- this calls UltiSnips
--       vim.fn["UltiSnips#Anon"](args.body)
--     end,
--   },
--   sources = cmp.config.sources({
--     { name = "ultisnips" },  -- <- use this source
--     -- other sources
--     { name = "nvim_lsp" },
--     { name = "path" },
--     { name = "buffer" },
--   }),
--   -- the rest of your mapping/config...
-- })
