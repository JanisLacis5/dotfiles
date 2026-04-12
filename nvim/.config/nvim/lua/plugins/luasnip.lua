-- Snippet engine setup + minimal keymaps
local ok, ls = pcall(require, 'luasnip')
if not ok then return end

-- Optional: load VSCode-style snippet packs if present
pcall(function() require('luasnip.loaders.from_vscode').lazy_load() end)

-- Jump forward/back within snippets
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(-1) then ls.jump(-1) end
end, { silent = true })
