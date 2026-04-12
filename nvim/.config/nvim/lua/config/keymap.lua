vim.keymap.set("i", "<C-Del>", "<C-o>dw")
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set('n', '<Tab>', ':BufferNext<CR>')
vim.keymap.set('n', '<S-Tab>', ':BufferPrevious<CR>')
vim.keymap.set('n', '<leader><Tab>', ':BufferClose<CR>')
vim.keymap.set('n', '<leader>f', ":FzfLua files<CR>")
vim.keymap.set('n', '<C-\\>', function() require("FTerm").toggle() end)
vim.keymap.set('t', '<C-\\>', function() require("FTerm").toggle() end)
vim.keymap.set('n', '<leader>v', ':vsplit<CR>')
vim.keymap.set("n", "<leader>h", ":split<CR>")
local function open_config_in_new_terminal()
  local nvim_dir = vim.fn.expand("~/.config/nvim")

  -- Try common Mint terminals, first one found wins
  local candidates = {
    { "gnome-terminal", "--", "bash", "-lc", "nvim " .. vim.fn.shellescape(nvim_dir) },
    { "xfce4-terminal", "--command", "nvim " .. nvim_dir },
    { "mate-terminal",  "--", "bash", "-lc", "nvim " .. vim.fn.shellescape(nvim_dir) },
    { "tilix", "-e", "nvim " .. nvim_dir },
    { "konsole", "-e", "nvim " .. nvim_dir },
    { "xterm",   "-e", "nvim " .. nvim_dir },
  }

  for _, cmd in ipairs(candidates) do
    if vim.fn.executable(cmd[1]) == 1 then
      vim.fn.jobstart(cmd, { detach = true })
      return
    end
  end
  vim.notify("No known terminal found. Edit the command list for your terminal.", vim.log.levels.ERROR)
end
vim.keymap.set("n", "<leader>mv", open_config_in_new_terminal)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "<A-S-j>", function()
  vim.cmd("move .+" .. vim.v.count1); vim.cmd("normal! ==")
end, { silent = true })
vim.keymap.set("n", "<A-S-k>", function()
  vim.cmd("move .-" .. (vim.v.count1 + 1)); vim.cmd("normal! ==")
end, { silent = true })
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", { desc = "Decrease Window Width" })
