local mason = require("mason")
local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")

mason.setup()
mason_dap.setup({
  ensure_installed = { "codelldb" }, -- will auto-install
  automatic_installation = true,
})

dapui.setup()
require("nvim-dap-virtual-text").setup()

-- Open/close UI automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- codelldb adapter path (Mason installs this)
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = mason_path .. "adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
        local a = vim.fn.input("Args: ")
        return vim.split(a, " ")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp

vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end)
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end)
vim.keymap.set("n", "<leader>dq", ":DapTerminate<CR>")
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

