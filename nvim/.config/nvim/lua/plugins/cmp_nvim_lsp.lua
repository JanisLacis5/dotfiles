-- Expose LSP client capabilities for nvim-cmp
local M = {}

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
else
  M.capabilities = vim.lsp.protocol.make_client_capabilities()
end

return M

